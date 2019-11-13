class Users::ReportsController < ApplicationController
  before_action :authenticate_user!

  def show
    report_dates = current_user.report_dates
    @work_days = current_user.work_days
      .where(
        'day >= ? AND day <= ?',
        report_dates[:start_date],
        report_dates[:end_date]
      )
      .order(:day)
  end
end
