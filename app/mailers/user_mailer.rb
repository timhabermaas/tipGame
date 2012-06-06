class UserMailer < ActionMailer::Base
  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.mail}>",
         :from => "TippSpiel <cin9247@gmail.com>",
         :subject => "Willkommen bei TipEM" )
  end

  def password_reset_instructions(user)
    @user = user
    @password_reset_url = edit_password_reset_url(user.perishable_token)
    mail(:to => "#{user.name} <#{user.mail}>",
         :from => "Tippspiel <cin9247@gmail.com>",
         :subject => "TipEm - Neues Passwort anlegen")
  end

  def remind_about_matches(user, matches)
    @user = user
    @matches = matches
    @user.reminded!
    mail(:to => "#{user.name} <#{user.mail}>",
         :from => "Tippspiel <cin9247@gmail.com>",
         :subject => "TipEM - Erinnerung an ausstehende Spiele")
  end
end
