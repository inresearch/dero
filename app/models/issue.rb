# The unique occurent of each panic. Issue can have many error context.
class Issue
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :starrers, type: Array
  field :status, type: String # open, ignored, resolved, deleted
  field :status_modifier, type: String
  field :contexts, type: Array
end
