class Backtrace
  attr_reader :file_name, :line_of_codes, :executed_line

  def initialize(states={})
    # /var/apps/something/file_printer.rb
    @file_name = states.fetch(:file_name)

    # [[97, "i = i + 10"],
    #  [98, "print(i)"]]
    @line_of_codes = states.fetch(:line_of_codes)

    # 98
    @executed_line = states.fetch(:executed_line)
  end

  def mongoize
    fail "Executed line must be an integer" unless executed_line.is_a?(Fixnum)
    fail "File name must be a string" unless file_name.is_a?(String)
    fail "Line of codes must be an array" unless line_of_codes.is_a?(Array)

    {
      file_name: file_name,
      line_of_codes: line_of_codes,
      executed_line: executed_line
    }
  end

  def self.demongoize(states)
    Backtrace.new(states)
  end

  def self.mongoize(object)
    case object
    when Backtrace then object.mongoize
    when Hash then Backtrace.new(object).mongoize
    else object
    end
  end

  # converts the object that was supplied to a criteria and converts it
  # into a database friendly form
  def self.evolve(object)
    case object
    when Backtrace then object.mongoize
    else object
    end
  end
end
