require 'pry'
class TasksController < ApplicationController


  def index

    @tasks = User.find(session[:user_id]).tasks

  end

  def new
    @user = User.find(session[:user_id])
    @project = Project.find(params[:project_id])
    @sections = @project.sections
    @task = Task.new(project_id: @project.id,creator:@user.id)
    #@task.build_section(project_id:@project.id)
  end



  def create
    @task = Task.create(task_params)
    @task.assign_task
    @user = User.find(session[:user_id])
    UserTask.create(user_id: @user.id,task_id: @task.id)
    #binding.pry
    redirect_to project_task_path(@task.project.id,@task.id)
  end

  def show
    @user = User.find(session[:user_id])
    #@project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
    @assignee = User.find(@task.assignee).name
    #binding.pry
    @project = @task.project
  end

  def edit
    @user = User.find(session[:user_id])

    @task = @user.tasks.find(params[:id])
    @project = @task.project
      @sections = @project.sections
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    redirect_to project_task_path(@task.project.id,@task.id)

  end

  def destroy
    binding.pry
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to homepage_path
  end

  private
  def task_params
    params.require(:task).permit(:name,:creator,:section_id,:project_id,:status,:assignee,section_attributes:[:name,:project_id,:status,:creator])
  end

end
