describe CodeLine do
  it 'must have line number and code' do
    subject = described_class.new
    expect(subject.valid?).to eq false
  end
end # CodeLine
