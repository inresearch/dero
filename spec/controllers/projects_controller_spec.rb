require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before { Timecop.freeze(Date.parse("10/10/2020")) }
  after { Timecop.return }

  describe 'POST #create' do
    let(:params) { { project: { name: 'Dero' } } }

    it 'can create new project' do
      post :create, params: params
      expect(parsed_body).to eq({
        id: Project.first.id.to_s,
        name: "Dero",
        created_at: 1602288000.0,
        updated_at: 1602288000.0
      })
    end

    it 'cannot create proejct with the same name' do
      post :create, params: params
      post :create, params: params
      expect(parsed_body).to eq ({
        success: false,
        errors: {
          base: "Name is already taken",
        },
        displayable_error: true
      })
    end
  end
end
