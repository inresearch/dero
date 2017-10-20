# The root document. Panic has a lot of issues.
class Panic
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :panic_class, type: String
  field :panicked_file, type: String
  field :offending_line, type: String
  field :panic_message, type: String
  field :issues, type: Array
  field :project_id, type: BSON::ObjectId
  #field :severity_level

  attr_readonly :panic_class, :panicked_file, :offending_line, :panic_message,
    :backtrace, :project_id

  belongs_to :project
  embeds_many :issues
  embeds_many :backtraces
end
