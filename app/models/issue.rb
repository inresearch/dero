# The unique occurent of each panic. Issue can have many error context.
class Issue
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :starrers, type: Array
  field :status, type: String # open, ignored, resolved, deleted
  field :status_modifier, type: String

  OPEN = 'open'.freeze
  IGNORED = 'ignored'.freeze
  RESOLVED = 'resolved'.freeze
  DELETED = 'deleted'.freeze
  STATUSES = [OPEN, IGNORED, RESOLVED, DELETED].freeze

  validates_inclusion_of :status, in: STATUSES
  validate :status_state_change
  after_initialize :assign_default_status, if: -> { new_record? }

  embedded_in :panic
  embeds_many :error_contexts

  private

  def status_state_change
    if (STATUSES - [OPEN]).include?(status_was) && status == OPEN
      fail "Cannot open back the issue"
    end
  end

  def assign_default_status
    self.status = OPEN
  end
end
