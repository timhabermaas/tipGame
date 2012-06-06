class UserReminder
  def self.remind(users, user_mailer = UserMailer)
    users.each do |user|
      user_mailer.remind_about_matches(user, user.forgotten_matches) unless user.forgotten_matches.empty?
    end
  end
end
