FactoryGirl.define do
  factory :match do
    team_1_name "Deutschland"
    team_2_name "Portugal"
    starts_at { DateTime.new }
    finished false
  end

  factory :tip do
    user_id 3
    match
  end
end
