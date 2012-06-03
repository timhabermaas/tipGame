FactoryGirl.define do
  factory :match do
    team_1_name "Deutschland"
    team_2_name "Portugal"
    starts_at { DateTime.new }
    finished false
    sequence(:match_id) { |n| n }
  end

  factory :tip do
    user_id 3
    match
  end
end
