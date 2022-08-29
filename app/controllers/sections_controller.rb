class SectionsController < ApplicationController
  include ApplicationHelper
  before_action :require_login
  layout "menu"
  def index

  end


  def new
    @user = User.find(session[:user_id])
    @project = Project.find(params[:project_id])
    @section = Section.new(project_id: params[:project_id],creator: @user.id)
  end

  def create
    @user = User.find(session[:user_id])
    @project = Project.find(params[:section][:project_id])
    #@section = Section.find_or_create_by(section_params)
    @section = Section.find_or_create_by(name: params[:section][:name])
    @section.update(status:params[:section][:status] ,creator:params[:section][:creator] ,project_id:params[:section][:project_id])
    if(!@section.valid?)
      redirect_to new_project_section_path(@project.id)
    else
    if(!@project.sections.include?(@section))
      @project.sections << @section
    end
    redirect_to project_path(@project)
    end
  end

  def show
    @user = User.find(session[:user_id])
    @section = Section.find(params[:id])
    @project = @section.project
    @task = @section.tasks.build(section_id: @section.id, project_id: @project.id, creator: @user.id)
  end

  def edit
    @project = Project.find(params[:project_id])
    @section = @project.sections.find(params[:id])
  end

  def update
    @project = Project.find(params[:section][:project_id])
    @section = @project.sections.find(params[:id])
    @section.update(section_params)
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
    params.require(:section).permit(:name,:project_id,:status,:creator)
  end
end
