FactoryGirl.define do
  factory :user do
    name "Peter"
    password "secret"
    password_confirmation "secret"
    mail "peter@muh.com"
  end

  factory :match do
    team_1_name "Deutschland"
    team_2_name "Portugal"
    starts_at { Time.now }
    finished false
    sequence(:match_id) { |n| n }
  end

  factory :tip do
    user_id 3
    match
    goals_team_1 2
    goals_team_2 3
  end
end
