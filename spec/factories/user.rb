FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    transient do
      date_range { 1.month.ago.to_date .. 0.days.ago.to_date }
    end

    trait :with_report do
      after(:create) do |user|
        create :report, user: user
      end
    end

    trait :with_work_days do
      after(:create) do |user, evaluator|
        evaluator.date_range.each do |date|
          create :work_day,
            user: user,
            day: date,
            arrived_at: date + 9.hours + rand(60).minutes,
            left_at: date + 17.hours + rand(60).minutes
        end
      end
    end

    factory :user_with_work_days, traits: [:with_work_days]

    factory :user_with_report, traits: [:with_report]

    factory :user_with_work_days_and_report, traits: [:with_work_days, :with_report]
  end

  factory :invalid_user, class: User do
  end
end
