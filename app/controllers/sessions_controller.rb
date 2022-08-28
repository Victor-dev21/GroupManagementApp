class SessionsController < ApplicationController


  def new
    @user = User.new
  end


  def create
    #binding.pry
    if(!params[:user].nil?)
      @user = User.find_by(username: params[:user][:username])
      if(@user && @user.authenticate(params[:user][:password]))
        session[:user_id] = @user.id
        redirect_to homepage_path
        else
          redirect_to login_path
        end
      else
        #binding.pry
        @user =
          User.find_or_create_by(uid: auth['uid']) do |u|
            u.name = auth['info']['nickname']
            u.username = auth['info']['nickname']
            u.password = "rando"
          end
          binding.pry
        session[:user_id] = @user.id
        redirect_to homepage_path

      end


  end

  def destroy
    session.clear
    redirect_to login_path
  end


  def auth
    request.env['omniauth.auth']
  end
end
