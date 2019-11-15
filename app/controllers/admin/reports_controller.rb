class Admin::ReportsController < Admin::ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource through: :user, singleton: true, except: :create
  load_and_authorize_resource :work_day, through: :user
  before_action :set_work_days, only: :show

  def create
    @report = @user.report || @user.build_report(report_params)
    authorize! :create, @report

    if @report.save
      set_work_days
      render :show, status: :created, location: [:admin, @user, :report]
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      set_work_days
      render :show, status: :ok, location: [:admin, @user, :report]
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy
  end

  private

  def set_work_days
    @work_days = @user.report_work_days
  end

  def report_params
    params.require(:report).permit(:start_date, :end_date)
  end
end
