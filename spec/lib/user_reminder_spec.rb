require "user_reminder"

describe UserReminder do
  let(:user_mailer) { stub(:user_mailer) }

  context "#remind" do
    let(:matches) { [stub(:match), stub(:match)] }
    let(:user1) { stub(:user1, :forgotten_matches => matches, :remindable? => true) }
    let(:user2) { stub(:user2, :forgotten_matches => [], :remindable? => false) }

    it "checks all users and reminds them by email if they forgot to bet on a match" do
      user_mailer.should_receive(:remind_about_matches).with(user1, matches)
      UserReminder.remind([user1, user2], user_mailer)
    end

    it "doesn't send an email if the user was reminded less than 24 hours ago" do
      user1.stub(:remindable? => false)

      UserReminder.remind([user1, user2], user_mailer)
      user_mailer.should_not_receive(:remind_about_matches)
    end
  end
end
