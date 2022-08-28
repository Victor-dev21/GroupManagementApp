class SectionsController < ApplicationController
  include ApplicationHelper
  before_action :require_login

  def index

  end


  def new
    @user = User.find(session[:user_id])
    @project = Project.find(params[:project_id])
    @section = Section.new(project_id: params[:project_id],creator: @user.id)
  end

  def create
    @user = User.find(session[:user_id])
    @section = Section.find_or_create_by(name: params[:section][:name])
    @project = Project.find(params[:section][:project_id])
    @section.update(project_id:@project.id,status:params[:section][:status],creator:@user.id)
    #binding.pry
    if(!@project.sections.include?(@section))
      @project.sections << @section
      #binding.pry
    end
    #redirect_to project_section_path(@section.project.id,@section.id)
    @section.save
    #binding.pry
    redirect_to project_path(@project)
  end

  def show

    @section = Section.find(params[:id])
    @project = @section.project
    @task = @section.tasks.build
    #@task.project =
  end

  def edit
    @project = Project.find(params[:project_id])
    @section = @project.sections.find(params[:id])
  #  binding.pry
  end

  def update

    @project = Project.find(params[:section][:project_id])
    #binding.pry
    @section = @project.sections.find(params[:id])
    @section.update(section_params)
    #binding.pry
    redirect_to user_project_path(User.find(session[:user_id]),@project.id)
  end


  def destroy
    @project = Project.find(params[:project_id])
    @section = @project.sections.find(params[:id])
    @section.destroy
    redirect_to user_project_path(User.find(session[:user_id]),@project.id)

  end

private

  def section_params
    params.require(:section).permit(:name,:project_id,:status)
  end
end
