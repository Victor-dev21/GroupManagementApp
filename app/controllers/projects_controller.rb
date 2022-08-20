class ProjectsController < ApplicationController
  def index
    @projects = User.find().projects
  end

  def new
    @project = Project.new
  end

  def create
  end

  def show
  end


  def project_params(*args)

  end

end
