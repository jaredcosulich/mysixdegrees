module ApplicationHelper

  def connected_providers_for(user)
    user.user_tokens.collect{|u| u.provider.to_sym }
  end

  def unconnected_providers_for(user)
    User.omniauth_providers - user.user_tokens.collect{|u| u.provider.to_sym }
  end

  def notice_html
    "<div class=\"notice\">#{notice}</div>" unless notice.blank?
  end

  def alert_html
    "<div class=\"alert\">#{alert}</div>" unless alert.blank?
  end

  def word_chart(user, words, good)
    name = user.name || user.slug
    word_map = words.inject(Hash.new{|h,k| h[k] = 0}) { |map, w| map[w.smart_word.downcase] += 1; map }
    sorted_words = word_map.to_a.sort_by { |word_info| word_info[1] }.reverse[0...5]

    img_src = ["http://chart.apis.google.com/chart?chxl=1:|"]
    img_src << sorted_words.reverse.collect { |word_info| word_info[0] }.join("|")
    img_src << "&chxr=0,0,#{sorted_words.first[1] + (sorted_words.first[1].to_f * 0.10).ceil},#{(sorted_words.first[1].to_f / 10.0).ceil}"
    img_src << "&chxt=x,y"
    img_src << "&chbh=a,12"
    img_src << "&chs=300x#{60 + (sorted_words.length * 30)}"
    img_src << "&cht=bhs"
    img_src << "&chco=#{good ? "008000" : "AA0033"}"
    img_src << "&chds=0,#{sorted_words.first[1] + (sorted_words.first[1].to_f * 0.10).ceil}"
    img_src << "&chd=t:"
    img_src << sorted_words.collect { |word_info| word_info[1] }.join(",")
    img_src << "&chma=|#{sorted_words.length}"
    img_src << "&chtt=Top #{sorted_words.length} #{good ? "Best" : "Worst"} Words"
    img_src << "&chts=676767,16"

    "<img class='word_chart' src=\"#{img_src.join('')}\" width=\"300\" height=\"#{60 + (sorted_words.length * 30)}\" alt=\"Top #{sorted_words.length} #{good ? "Best" : "Worst"} Words\"/>".html_safe
  end

  def grouped_words(user_words)
    map = Hash.new { |h,k| h[k] = {}}
    user_words.each do |uw|
      map[uw.ip][:time] = uw.created_at if map[uw.ip][:time].nil? || map[uw.ip][:time] < uw.created_at
      map[uw.ip][:signature] = uw.smart_signature if map[uw.ip][:signature].nil?
      map[uw.ip][:good_words] = [] if map[uw.ip][:good_words].nil?
      map[uw.ip][:bad_words] = [] if map[uw.ip][:bad_words].nil?
      map[uw.ip][:good_words] << uw if uw.good?
      map[uw.ip][:bad_words] << uw if !uw.good?
    end
    map.to_a
  end

end
