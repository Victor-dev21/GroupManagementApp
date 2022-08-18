class UsersController < ApplicationController
  def index

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      redirect_to new_user
    end
  end

  def show
    @user = User.find(params[:id])
  end


  def user_params(*args)
    params.require(:user).permit(:name,:username,:password)
  end



end
