class UserMailer < ActionMailer::Base
  default :from => "cin9247@gmail.com"

  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.mail}>",
         :from => "TippSpiel <info@alles-und-nicht-mehr.de>",
         :subject => "Willkommen bei TipEM" )
  end

  def password_reset_instructions(user)
    @user = user
    @password_reset_url = edit_password_reset_url(user.perishable_token)
    mail(:to => "#{user.name} <#{user.mail}>",
         :from => "Tippspiel",
         :subject => "TippSpiel.de - Neues Passwort anlegen")
  end
end
