class WorkDay < ApplicationRecord
  belongs_to :user

  validates :day, presence: true, uniqueness: { scope: :user_id }

  validates_datetime :left_at, on_or_after: :arrived_at, allow_blank: true

  validates_date :arrived_at, is_at: :day, allow_blank: true
  validates_date :left_at, is_at: :day, allow_blank: true
end
