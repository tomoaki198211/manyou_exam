class Admin::UsersController < ApplicationController
  before_action :only_admin

  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice:"作成しました"
    else
      render :new
    end
  end

  def update
    set_user
    if @user.update(user_params)
      redirect_to admin_users_path, notice:"更新しました"
    else
      render :edit
    end

  end

  def show
    set_user
  end

  def edit
    set_user
  end

  def destroy
    set_user
    if @user.destroy
      redirect_to admin_users_path, notice:"削除しました"
    else
      render :edit
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_digest, :admin)
  end


  def only_admin
    unless current_user.admin?
      redirect_to tasks_path
      flash[:notice] = "管理者以外はアクセスできません"
    end
  end
end
