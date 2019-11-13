FactoryBot.define do
  factory :work_day do
    day { "2019-11-12" }
    arrived_at { "2019-11-12 10:00:00" }
    left_at { "2019-11-12 19:00:00" }
    user
  end

  factory :invalid_work_day, class: WorkDay do
  end
end
