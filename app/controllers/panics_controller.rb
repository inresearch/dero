class PanicsController < ApplicationController
  def create
    create_new
  end

  def panic_params
    params.require(:panic).permit(
      :kind,
      :file,
      :line,
      :severity_level,
      :message,
      :code_lines => [:line, :code]
    )
  end

  def project_params
    params.require(:project).permit(:name)
  end

  def issue_params
    params.require(:issue).permit(error_contexts: [:key, :value])
  end

  private

  def create_new
    project = Project.find_by(name: project_params[:name])
    panic = Panic.new(panic_params)
    panic.project = project
    panic.issues = [Issue.new(issue_params)]
    panic.save
  end
end
