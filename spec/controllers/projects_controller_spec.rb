require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before { Timecop.freeze(Date.parse("10/10/2020")) }
  after { Timecop.return }

  describe 'POST #create' do
    let(:params) { { project: { name: 'Dero' } } }

    it 'can create new project' do
      post :create, params: params
      expect(parsed_body).to eq({
        success: true,
        errors: {},
        data: {
          id: Project.first.id.to_s,
          name: "Dero",
          created_at: 1602288000.0,
          updated_at: 1602288000.0,
          deleted_at: nil
        }
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
  end # POST #create

  describe 'DELETE #destroy' do
    let(:project) { build_project }
    before { project.save! }

    it 'can destroy the project' do
      delete :destroy, params: {id: project.id.to_s}
      expect(parsed_body).to eq({
        success: true,
        errors: {},
        data: {
          id: Project.first.id.to_s,
          name: 'Dero',
          created_at: 1602288000.0,
          updated_at: 1602288000.0,
          deleted_at: 1602288000.0
        }
      })
    end
  end
end
