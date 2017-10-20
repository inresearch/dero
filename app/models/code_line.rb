class CodeLine
  include Mongoid::Document

  field :line_number, type: Integer
  field :code, type: String

  validates_presence_of :line_number, :code
  attr_readonly :line_number, :code

  embedded_in :backtrace
end
