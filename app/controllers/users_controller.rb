class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
    else
      render :new
    end
  end

  def show

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
