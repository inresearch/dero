class ProjectsController < ApplicationController
  def create
    project = Project.new(project_params)
    project.save!
    render json: ProjectSerializer.new(project).to_h
  end

  def destroy
    project = Project.find(params[:id])
    project.deleted_at = Time.current
    project.save!
    render json: ProjectSerializer.new(project).to_h
  end

  protected

  def project_params
    params.require(:project).permit(:name)
  end
end
