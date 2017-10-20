class Backtrace
  include Mongoid::Document

  field :file_name, type: String
  field :executed_line, type: String

  validates_presence_of :file_name, :line_of_codes, :executed_line
  attr_readonly :file_name, :line_of_codes, :executed_line
  embedded_in :panic 
  embeds_many :code_lines
end
