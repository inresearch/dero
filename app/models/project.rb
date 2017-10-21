# Project has many panics. But the document is linked, instead of embedded.
class Project
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :name, type: String
  # index name
  
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :panics
end
