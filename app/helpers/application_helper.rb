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

  def path(from, last_connection)
    return nil if @from.empty?
    path = from[-2] == last_connection.to_profile.slug ? @from[0,-2] : @from
    path.blank? ? nil : path.join(",")
  end
end
