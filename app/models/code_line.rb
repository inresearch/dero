class CodeLine
  include Mongoid::Document

  field :line, type: Integer
  field :code, type: String

  validates_presence_of :line, :code
  attr_readonly :line, :code

  embedded_in :panic 
end
