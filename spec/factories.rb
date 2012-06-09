FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Peter#{n}" }
    password "secret"
    password_confirmation "secret"
    sequence(:mail) { |n| "peter#{n}@muh.com" }
  end

  factory :match do
    team_1_name "Deutschland"
    team_2_name "Portugal"
    starts_at { Time.now }
    finished false
    sequence(:match_id) { |n| n }
  end

  factory :match_with_result, :parent => :match do
    goals_team_1 3
    goals_team_2 1
  end

  factory :tip do
    user
    match
    goals_team_1 2
    goals_team_2 3
  end
end
