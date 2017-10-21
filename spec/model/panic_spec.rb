describe Panic do
  let(:project) { build_project }
  let(:panic) { build_panic(project) }

  before do
    project.save
  end

  context 'saved' do
    before { panic.save }
    
    it 'has many issues' do
      expect(panic.issues.length).to eq 4
      expect(panic.issues.first).to_not be_new_record
    end

    it 'belongs to a project' do
      expect(panic.project).to eq project
      expect(panic.project).to_not be_new_record
    end

    it 'has many code of lines' do
      expect(panic.code_lines.length).to eq 4
      expect(panic.code_lines.first).to_not be_new_record
    end

    it 'has many issues that has many error contexts' do
      issue = panic.issues.first
      expect(issue.error_contexts.length).to eq 2
      issue.error_contexts.each do |ctx|
        expect(ctx).to_not be_new_record
      end
    end
  end
end
