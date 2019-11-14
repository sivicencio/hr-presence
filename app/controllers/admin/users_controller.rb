class Admin::UsersController < Admin::ApplicationController
  load_and_authorize_resource

  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created, location: [:admin, @user]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render :show, status: :ok, location: [:admin, @user]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :name, :position, :role)
  end
end
