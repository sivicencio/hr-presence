class Admin::WorkDaysController < Admin::ApplicationController
  before_action :set_user, only: [:show, :create, :update, :destroy]
  before_action :set_work_day, only: [:show, :update, :destroy]
  load_and_authorize_resource :user
  load_and_authorize_resource through: :user

  def create
    @work_day = @user.work_days.build(work_day_params)

    if @work_day.save
      render :show, status: :created, location: [:admin, @user, @work_day]
    else
      render json: @work_day.errors, status: :unprocessable_entity
    end
  end

  def update
    if @work_day.update(work_day_params)
      render :show, status: :ok, location: [:admin, @user, @work_day]
    else
      render json: @work_day.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @work_day.destroy
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_work_day
    @work_day = @user.work_days.find_by(id: params[:id]) || @user.work_days.find_by(day: params[:id])
  end

  def work_day_params
    params.require(:work_day).permit(:day, :arrived_at, :left_at)
  end
end
