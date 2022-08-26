class ProjectsController < ApplicationController
  def index
    #@projects = User.find().projects
    if(session[:user_id])
      @projects = User.find(params[:user_id]).projects
    end
  end

  def new
    #@user = User.find(session[:user_id])
    @project = Project.new(creator: @user)
  end

  def create
    @user = User.find(session[:user_id])
    @project = Project.create(name: params[:project][:name],creator: @user)
    UserProject.create(user_id: @user.id,project_id: @project.id)
    @user.projects << @project
    redirect_to user_project_path(@user.id,@project.id)
  end

  def show
    @project = Project.find(params[:id])
    @sections = @project.sections
    puts @sections.length
  end


  def project_params(*args)

  end

end
