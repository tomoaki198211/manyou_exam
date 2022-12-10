class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    redirect_to user_path(current_user.id) if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    set_user
    redirect_to tasks_path unless @user.id == current_user.id
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name,
                          :password, :password_confirmation)
  end

end
