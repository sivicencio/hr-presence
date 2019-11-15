class Users::ReportsController < ApplicationController
  before_action :authenticate_user!

  def show
    @work_days = current_user.report_work_days
  end
end
