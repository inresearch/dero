# Project has many panics. But the document is linked, instead of embedded.
class Project
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :name, type: String

  has_many :panics
end
