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
    if(!@project.sections.include?(@section))
      @project.sections << @section
    end

    #redirect_to project_section_path(@section.project.id,@section.id)
    redirect_to project_path(@project)
  end

  def show
    @section = Section.find(params[:id])
  end


  def destroy

  end
end
