namespace :users do
  desc "Remind users about matches they haven't yet placed a bet on"
  task :remind => :environment do
    UserReminder.remind(User.all)
  end
end
