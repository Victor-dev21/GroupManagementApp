require 'pry'
class TasksController < ApplicationController


  def index

  end

  def new
    @user = User.find(session[:user_id])
    @project = Project.find(params[:project_id])
    @sections = @project.sections
    @task = Task.new(project_id: @project.id)
    #@task.build_section(project_id:@project.id)
  end



  def create
    @task = Task.create(task_params)
    
    @user = User.find(session[:user_id])
    UserTask.create(user_id: @user.id,task_id: @task.id)
    binding.pry
    redirect_to project_task_path(@task.project.id,@task.id)
  end

  def show
    @user = User.find(session[:user_id])
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
  end

  private
  def task_params
    params.require(:task).permit(:name,:section_id,:project_id,:status,:assignee,section_attributes:[:name,:project_id,:status])
  end

end
