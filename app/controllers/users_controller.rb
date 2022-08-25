class UsersController < ApplicationController
  def index

  end

  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)
    puts "::::::::::::::::::::::::::::"
    if @user.save
      session[:user_id] = @user.id
      redirect_to homepage_path
    else
      #redirect_to signup_path
      #puts "Here"
      render :new
    end
  end

  def show
    @user = User.find(session[:user_id])
    render 'users/homepage'
  end


  def user_params
    params.require(:user).permit(:name,:username, :password, :password_confirmation)
  end



end
