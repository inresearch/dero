# The root document. Panic has a lot of issues.
class Panic
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :kind, type: String # the class of error
  field :file, type: String
  field :line, type: Integer
  field :message, type: String
  field :severity_level, type: String
  field :fingerprint, type: String

  NORMAL_SEVERITY = 'normal'.freeze
  URGENT_SEVERITY = 'urgent'.freeze
  SEVERITY_LEVELS = [NORMAL_SEVERITY, URGENT_SEVERITY].freeze

  validates_inclusion_of :severity_level, in: SEVERITY_LEVELS
  after_initialize :assign_default_severity_level, if: -> { new_record? }
  before_save :calculate_fingerprint, if: -> { new_record? }

  attr_readonly :kind, :file, :line, :message, :fingerprint

  belongs_to :project
  embeds_many :issues
  embeds_many :code_lines

  def self.fingerprint(states = {})
    states = states.with_indifferent_access
    kls, file, line, msg = states.fetch(:kind),
      states.fetch(:file),
      states.fetch(:line),
      states.fetch(:message)
    code_lines = [].tap do |lines|
      states.fetch(:code_lines).each do |line_def|
        line, code = line_def.fetch(:line), line_def.fetch(:code)
        lines << [line, code]
      end
    end
    data = [kls, file, line, msg, code_lines.to_s].join("==")
    Digest::MD5.hexdigest(data)
  end

  private

  def assign_default_severity_level
    self.severity_level = NORMAL_SEVERITY
  end

  def calculate_fingerprint
    atr = attributes.merge(code_lines: code_lines.to_a.map(&:attributes))
    write_attribute(:fingerprint, self.class.fingerprint(atr))
  end
end
