describe Panic do
  let(:project) { build_project }
  let(:panic) { build_panic(project) }

  before do
    project.save
  end

  context 'static method' do
    describe '#fingerprint' do
      it 'calculates the fingerprint' do
        fingerprint = Panic.fingerprint(to_fingerprint_params(panic))
        data = %Q{StandardError==/var/app/calculator.rb==13==Division by zero==[["10", "i = i + 1"], ["11", "10.times do |i|"], ["12", "  i = i / 0"], ["13", "end"]]}
        expect(fingerprint).to eq Digest::MD5.hexdigest(data)
      end
    end # fingerprint
  end # static method

  context 'saved' do
    before { panic.save }
    
    it 'has many issues' do
      expect(panic.issues.length).to eq 4
      expect(panic.issues.first).to_not be_new_record
    end

    it 'has fingerprint' do
      expect(panic.fingerprint).to_not be_blank
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
