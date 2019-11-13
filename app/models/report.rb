class Report < ApplicationRecord
  belongs_to :user

  validates_date :end_date, on_or_after: :start_date, allow_blank: true
end
