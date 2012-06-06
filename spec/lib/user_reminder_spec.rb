require "user_reminder"

describe UserReminder do
  let(:user_mailer) { stub(:user_mailer) }

  context "#remind" do
    it "checks all users and reminds them by email if they forgot to bet on a match" do
      matches = [stub(:match)]
      user1 = stub(:user, :forgotten_matches => matches)
      user2 = stub(:user, :forgotten_matches => [])

      user_mailer.should_receive(:remind_about_matches).with(user1, matches)
      UserReminder.remind([user1, user2], user_mailer)
    end

    it "doesn't send an email if the user was reminded less than 24 hours ago"
  end
end
