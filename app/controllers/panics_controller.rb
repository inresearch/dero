class PanicsController < ApplicationController
  def create
    fingerprint = Panic.fingerprint(panic_params.to_h)
    panic = Panic.where(fingerprint: fingerprint).first
    panic ? update_panic(panic) : create_new
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

  def update_panic(panic)
    issue_params
    issue = Issue.new(issue_params)
    panic.issues << issue
    panic.save
  end
end
