class ProjectsController < ApplicationController
  include ApplicationHelper
  before_action :require_login
  layout "menu"

  def index
    #@projects = User.find().projects
    @user = current_user(session)
    if(session[:user_id])
      @projects = @user.projects
    end
  end

  def new
    @user = current_user(session)
    @project = Project.new(creator: @user.id)

  end

  def create
    @user = current_user(session)
    @project = Project.create(project_params)
    #binding.pry
    #UserProject.create(user_id: @user.id,project_id: @project.id)
    #@project.creator = @user
    @project.save
    @user.projects << @project
    redirect_to user_project_path(@user.id,@project.id)
  end

  def show
    @user = current_user(session)
    @project = Project.find(params[:id])
    @sections = @project.sections
    #binding.pry
  end

  def edit
    @project = Project.find(params[:id])
    @user = current_user(session)
    #binding.pry
  end

  def update
    @project = Project.find(params[:id])
    @user = current_user(session)
    @project.update(project_params)
    #binding.pry
    redirect_to user_projects_path(@user.id)
  end

  def destroy
    #binding.pry
    @project = Project.find(params[:id])
    @user = current_user(session)

    @project.delete_data
      #binding.pry
    UserProject.where(project_id:@project.id)[0].destroy

    @project.destroy
    binding.pry
    #@project.destroy
    #binding.pry
    redirect_to user_projects_path(@user.id)
  end


  def project_params
    params.require(:project).permit(:name,:creator)
  end

end
