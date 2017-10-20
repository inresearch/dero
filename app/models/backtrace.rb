class Backtrace
  include Mongoid::Document

  field :file_name, type: String
  field :line_of_codes, type: String
  field :executed_line, type: String

  attr_readonly :file_name, :line_of_codes, :executed_line
  embedded_in :panic 

  class LineOfCode
    attr_accessor :line_number, :code
    def initialize(line_data)
      @line_number, @code = line_data[0], line_data[1]
    end

    def mongoize
      [@line_number, @code]
    end

    def self.demongoize(line_data)
      LineOfCode.new(line_data)
    end

    def self.mongoize(object)
      case object
      when LineOfCode then object.mongoize
      when Array then Backtrace.new(object).mongoize
      end
    end

    def self.evolve(object)
      case object
      when LineOfCode then object.mongoize
      else object
      end
    end
  end
end
