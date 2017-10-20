# The unique occurent of each panic. Issue can have many error context.
class Issue
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :starrers, type: Array
  field :status, type: String # open, ignored, resolved, deleted
  field :status_modifier, type: String

  embedded_in :panic
  embeds_many :error_contexts
end
