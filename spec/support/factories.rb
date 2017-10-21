def build_code_line(panic)
  [
    [10, 'i = i + 1'],
    [11, '10.times do |i|'],
    [12, '  i = i / 0'],
    [13, 'end']
  ].map do |data|
    line, code = data[0], data[1]
    code_line = CodeLine.new(line_number: line, code: code)
    code_line.panic = panic
    code_line
  end
end

def build_error_context(issue)
  [
    {provider: 'tiket.com'},
    {is_dormant: false}
  ].map do |data|
    ctx = ErrorContext.new
    key = data.keys[0]
    val = data[key]
    ctx.key = key
    ctx.value = val
    ctx.issue = issue
    ctx
  end
end

def build_issue(panic)
  issue = Issue.new
  issue.panic = panic
  issue
end

def build_panic(project)
  panic = Panic.new
  panic.panic_class = StandardError.name
  panic.panicked_file = "/var/app/calculator.rb"
  panic.offending_line = 12
  panic.panic_message = "Division by zero"

  issues = []
  4.times do
    issue = build_issue(panic)
    build_error_context(issue)
    issues << issue
    issue.save!
  end
  panic.issues = issues

  panic.project = project
  panic.code_lines = build_code_line(panic)
  panic
end

def build_project
  project = Project.new
  project.name = "Dero"
  project
end
