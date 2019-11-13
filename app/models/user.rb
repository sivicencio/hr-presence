class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  has_one :report
  has_many :work_days

  def report_dates
    {
      start_date: report.present? ? report.start_date : 1.month.ago.to_date,
      end_date: report.present? ? report.end_date : Date.current
    }
  end
end
