namespace :matches do
  desc 'Update Matches'
  task :update => :environment do
    UpdateMatches.perform
  end
end
