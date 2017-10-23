describe Project do
  let(:project) { build_project }
  before { project.save }

  describe '#name' do
    it 'is unique and case insensitive' do
      new_proj = build_project
      new_proj.name = 'DERO'
      expect(new_proj.name).to eq 'dero'
      new_proj.save
      expect(new_proj).to_not be_valid
      expect(new_proj).to be_new_record
    end
  end
end
