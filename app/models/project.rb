# Project has many panics. But the document is linked, instead of embedded.
class Project
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :name, type: String
  field :d_at, type: DateTime
  # index name
  
  validates_presence_of :name
  validates_uniqueness_of :name

  alias :deleted_at :d_at
  alias :deleted_at= :d_at=

  has_many :panics

  def deleted?
    !deleted_at.blank?
  end
end
