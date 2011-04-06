class ProfilesController < ApplicationController
  def index
    redirect_to profile_path(current_user)
  end

  def show
    if params[:id] == "sample_the_dog"
      @user = User::SAMPLE_USER
      @my_good_words = params.include?(:good_words) ? params[:good_words].split(",").map(&:strip).collect { |w| UserWord.new(:word => Word.new(:word => w), :signature => params[:signature], :created_at => Time.new, :good => true) unless w.blank? }.compact : []
      @my_bad_words = params.include?(:bad_words) ? params[:bad_words].split(",").map(&:strip).collect { |w| UserWord.new(:word => Word.new(:word => w), :signature => params[:signature], :created_at => Time.new, :good => false) unless w.blank? }.compact : []
      @good_words, @bad_words = UserWord::SAMPLE_WORDS.partition { |uw| uw.good? }
      @good_words += @my_good_words
      @bad_words += @my_bad_words
    else
      @user = User.find_by_slug(params[:id], :include => {:user_words => :word})

      if @user.nil?
        redirect_to '/' and return
      end

      @good_words, @bad_words = @user.user_words.partition { |uw| uw.good? }
      @my_good_words = @good_words.select { |w| w.ip == session_identifier}
      @my_bad_words = @bad_words.select { |w| w.ip == session_identifier}
    end

    @used_words = @good_words + @bad_words
    @owner = (current_user == @user && !params.include?(:friend_view))
  end
end
