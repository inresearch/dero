class ErrorContext
  include Mongoid::Document

  field :key, type: String
  field :value, type: String

  attr_readonly :key, :value
end
