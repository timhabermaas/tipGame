ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :authentication       => "plain",
  :user_name            => "cin9247@gmail.com",
  :password             => ENV['MAIL_PASSWORD'],
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "em-tipp.herokuapp.com"
