class UsersController < ApplicationController
  def index

  end

  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params(:name,:username,:password))
    if @user.valid?
      redirect_to user_path(@user)
    else
      #redirect_to signup_path
      #puts "Here"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end


  def user_params(*args)
    params.require(:user).permit(args)
  end



end
