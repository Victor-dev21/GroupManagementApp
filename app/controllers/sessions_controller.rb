class SessionsController < ApplicationController


  def new
    @user = User.new
  end


  def create
    @user = User.find_by(username: params[:user][:username])
    puts @user.methods
    if(@user.authenticate(params[:user][:password]))
      session[:user_id] = @user.id
      redirect_to homepage_path
    else
      redirect_to login_path
    end
  end
end
