class Mailer < ActionMailer::Base

  helper ApplicationHelper

  ADMIN_EMAILS = ["jared@mysixdegrees.me"]
  default_url_options[:host] = Rails.application.host
  default :from => "mysixdegrees.me <support@mysixdegrees.me>", :bcc => "emails@mysixdegrees.me", :host => Rails.application.host, :headers => {'X-SMTPAPI' => '{"category": "BestWords"}'}

  def notify_words_added(user_id, emailing, user_word_ids, signature)
    @user = User.find(user_id)
    @emailing = emailing
    @signature = signature.blank? ? "Someone" : signature
    @words = UserWord.where("id in (#{user_word_ids.join(',')})").includes(:word)
    mail(
      :to => nice_email_address_for_user(@user),
      :subject => "#{@signature} has added some words to your BestWords.Me page"
    )
  end

  def nice_email_address_for_user(user)
    nice_email_address(user.email, "secret person")
  end

  def nice_email_address(email, name)
    "#{"#{name}" unless name.blank?} <#{email}>"
  end

end
