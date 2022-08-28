class ProjectsController < ApplicationController
  include ApplicationHelper
  before_action :require_login

  def index
    #@projects = User.find().projects
    @user = User.find(session[:user_id])
    if(session[:user_id])
      @projects = @user.projects
    end
  end

  def new
    @user = User.find(session[:user_id])
    @project = Project.new(creator: @user.id)

  end

  def create
    @user = User.find(session[:user_id])
    @project = Project.create(project_params)
    #binding.pry
    UserProject.create(user_id: @user.id,project_id: @project.id)
    #@project.creator = @user
    @project.save
    @user.projects << @project
    redirect_to user_project_path(@user.id,@project.id)
  end

  def show
    @user = User.find(session[:user_id])
    @project = Project.find(params[:id])
    @sections = @project.sections
    puts @sections.length
  end

  def edit
    @project = Project.find(params[:project_id])
    @project.update(project_params)
  end

  def destroy
    @project = Project.find(params[:project_id])
    @project.destroy
    redirect_to homepage_path
  end


  def project_params
    params.require(:project).permit(:name,:creator)
  end

end
