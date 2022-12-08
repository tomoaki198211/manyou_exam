class Admin::UsersController < ApplicationController
  before_action :only_admin

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
  end

  def update
    set_user
    @user.update
  end

  def show
    set_user
  end

  def edit
    set_user
  end

  def destroy
    set_user
    @user.destroy
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_digest)
  end

  def admin?
    current_user.admin?
  end

  def only_admin
    redirect_to tasks_path unless admin?
  end
end
