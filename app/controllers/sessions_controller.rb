class SessionsController < ApplicationController


  def index

  end
  def new
    @user = User.new
    #binding.pry
  end


  def create
    #binding.pry
    @user = User.find_by(username: params[:user][:username])
    if !@user
      render :new
    end
    if(!params[:user].nil?)
      #binding.pry
      @user = User.find_by(username: params[:user][:username])
      if(!@user.nil? && @user.authenticate(params[:user][:password]))
        session[:user_id] = @user.id
        redirect_to homepage_path
        else
          render :new
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
      #render :new

  end

  def destroy
    session.clear
    redirect_to login_path
  end


  def auth
    request.env['omniauth.auth']
  end
end
