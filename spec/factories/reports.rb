FactoryBot.define do
  factory :report do
    start_date { "2019-11-01" }
    end_date { "2019-11-12" }
    user
  end

  factory :invalid_report, class: Report do
  end
end
