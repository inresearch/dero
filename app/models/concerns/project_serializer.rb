class ProjectSerializer
  attr_accessor :project

  def initialize(project)
    @project = project
  end

  def to_h
    data = {}
    data[:success] = !@project.new_record? && @project.errors.blank?
    data[:errors] = @project.errors.to_h
    data[:data] = {
      id: project.id.to_s,
      name: project.name,
      created_at: project.created_at.to_f,
      updated_at: project.updated_at.to_f,
      deleted_at: project.deleted_at ? project.deleted_at.to_f : nil
    }
    data
  end
end
