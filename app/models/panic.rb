# The root document. Panic has a lot of issues.
class Panic
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :panic_class, type: String
  field :panicked_file, type: String
  field :offending_line, type: String
  field :panic_message, type: String
  field :severity_level, type: String

  NORMAL_SEVERITY = 'normal'.freeze
  URGENT_SEVERITY = 'urgent'.freeze
  SEVERITY_LEVELS = [NORMAL_SEVERITY, URGENT_SEVERITY].freeze

  validates_inclusion_of :severity_level, in: SEVERITY_LEVELS
  after_initialize :assign_default_severity_level, if: -> { new_record? }

  attr_readonly :panic_class, :panicked_file, :offending_line, :panic_message,
    :severity_level

  belongs_to :project
  embeds_many :issues
  embeds_many :code_lines

  private

  def assign_default_severity_level
    self.severity_level = NORMAL_SEVERITY
  end
end
