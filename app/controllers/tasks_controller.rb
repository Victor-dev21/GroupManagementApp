require 'pry'
class TasksController < ApplicationController


  def index

  end

  def new
    @user = User.find(session[:user_id])
    @project = Project.find(params[:project_id])
    @sections = @project.sections
    @task = Task.new(project_id: @project.id)
    @task.build_section(project_id:@project.id)
  end

  def create
    #@assignee = User.find(params[:task][:user_ids])
    @task = Task.new(task_params)
    #binding.pry
    #puts @task.nested_attributes
    @project = Project.find(params[:task][:project_id])
    if(params[:task][:assignee].empty?)
      @task = Task.new(task_params)
      @user = User.find(session[:user_id])
      #@section = @project.sections.find_or_create_by(name: params[:task][:section_attributes][:name])
      @task.section = @task.project.sections.find(params[:task][:section_id])
      @task.update(assignee: @user.id)
      @project.sections << @task.section
      @task.save
      binding.pry
    elsif(params[:task][:section_id].empty?)
      @user = User.find(session[:user_id])
      #@task.section = Section.find(params[:task][:section_id])
      @task.save
      @project.tasks << @task
      binding.pry
    else
      @task.section = @task.project.sections.find(params[:task][:section_id])
      @task.save
      @project.tasks << @task
    end

    #@task.save
    #@project.tasks << @task
    binding.pry
    @user = User.find(session[:user_id])
    UserTask.create(user_id: @user.id,task_id: @task.id)
    redirect_to project_task_path(@project.id,@task.id)
  end

  def show
    @user = User.find(session[:user_id])
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name,:section_id,:project_id,:status,:assignee,section_attributes:[:name,:project_id])
  end

end
