class SectionsController < ApplicationController
  def index

  end


  def new
    @project = Project.find(params[:project_id])
    @section = Section.new(project_id: params[:project_id])
  end

  def create
    @section = Section.find_or_create_by(name: params[:section][:name])
    @project = Project.find(params[:section][:project_id])
    @section.update(project_id:@project.id,status:params[:section][:status])
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


  def destroy

  end

private

  def section_params

  end
end
