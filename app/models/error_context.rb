# For tagging additional context, or metadata about the error
# as user see it fit to make it easier in the effort of debuggin
class ErrorContext
  include Mongoid::Document

  field :key, type: String
  field :value, type: String

  attr_readonly :key, :value
  
  embedded_in :issue
end
