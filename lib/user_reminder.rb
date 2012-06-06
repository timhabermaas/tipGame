class UserReminder
  def self.remind(users, user_mailer = UserMailer)
    users.each do |user|
      if user.remindable? and not user.forgotten_matches.empty?
        user_mailer.remind_about_matches(user, user.forgotten_matches).deliver
      end
    end
  end
end
