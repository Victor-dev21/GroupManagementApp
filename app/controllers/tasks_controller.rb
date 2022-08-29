require 'pry'
class TasksController < ApplicationController
  include ApplicationHelper
  before_action :require_login
  layout "menu"

  def index
    @user = current_user(session)
    @tasks = current_user(session).tasks
    @assigned_tasks = Task.all.where(assignee: @user.id)
    #binding.pry
  end

  def new
    @user = current_user(session)
    @project = Project.find(params[:project_id])
    @sections = @project.sections
    @task = Task.new(project_id: @project.id,creator:@user.id)
    #@task.build_section(project_id:@project.id)
  end



  def create
    @task = Task.new(task_params)
    @project = Project.find(params[:task][:project_id])
    #binding.pry
    if @task.valid?
      @task.assign_task(session)
      @user = current_user(session)
      UserTask.create(user_id: @user.id,task_id: @task.id)
      redirect_to project_task_path(@task.project.id,@task.id)
    else
      #render new_project_task_path(@project.id)
      redirect_to new_project_task_path(@project.id)
    end
  end

  def show
    @user = current_user(session)
    #@project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
    @assignee = @task.display_assignee
    #binding.pry
    @project = @task.project
    #binding.pry
  end

  def edit
    @user = current_user(session)
    @task = @user.tasks.find(params[:id])
    @project = @task.project
    @sections = @project.sections
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)

    #@user_task = UserTask.where(user_id: @task.creator).update(user_id: @task.assignee)
    #binding.pry
    redirect_to project_task_path(@task.project.id,@task.id)

  end

  def destroy
  
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to homepage_path
  end

  private
  def task_params
    params.require(:task).permit(:name,:creator,:section_id,:project_id,:status,:assignee,section_attributes:[:name,:project_id,:status,:creator])
  end

end
