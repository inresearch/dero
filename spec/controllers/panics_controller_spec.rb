require 'rails_helper'

RSpec.describe PanicsController, type: :controller do
  let(:project) { build_project }
  before { project.save }

  describe "POST #create" do
    let(:params) {
      {
        project: {
          name: 'dero'
        },
        panic: {
          kind: 'ZeroDivisonError',
          file: '/var/app/file.rb',
          line: 12,
          severity_level: 'normal',
          message: 'Division by zero',
          code_lines: [
            {line: 10, code: 'number_1 = 10'},
            {line: 11, code: 'number_2 = 0'},
            {line: 12, code: 'number_1 / number_2'}
          ]
        },
        issue: {
          error_contexts: [
            {key: 'number_1', value: 10},
            {key: 'number_2', value: 0}
          ],
        }
      }
    }

    context 'no previous similar panic' do
      it 'creates all of its required records accordingly' do
        expect(Panic.count).to eq 0
        post :create, params: params
        p = Panic.first
        expect(p.kind).to eq 'ZeroDivisonError'
        expect(p.file).to eq '/var/app/file.rb'
        expect(p.line).to eq 12
        expect(p.severity_level).to eq 'normal'
        expect(p.message).to eq 'Division by zero'
        expect(p.code_lines.count).to eq 3
        expect(p.code_lines[0].line).to eq 10
        expect(p.code_lines[0].code).to eq 'number_1 = 10'
        expect(p.code_lines[1].line).to eq 11
        expect(p.code_lines[1].code).to eq 'number_2 = 0'
        expect(p.code_lines[2].line).to eq 12
        expect(p.code_lines[2].code).to eq 'number_1 / number_2'
        expect(p.issues.count).to eq 1
        i = p.issues.first
        expect(i.status).to eq Issue::OPEN
        expect(i.error_contexts[0].key).to eq 'number_1'
        expect(i.error_contexts[0].value).to eq '10'
        expect(i.error_contexts[1].key).to eq 'number_2'
        expect(i.error_contexts[1].value).to eq '0'
      end
    end # no previous similar panic

    context 'exist similar panic' do
      it 'appends issues but no new panic is created' do
        post :create, params: params
        p = Panic.first
        params[:issue][:error_contexts] = [
          {key: 'number_1', value: 5},
          {key: 'number_2', value: 0}
        ]
        expect(Panic.all.count).to eq 1
        expect(p.issues.count).to eq 1
        sleep 1

        post :create, params: params
        p.reload
        expect(Panic.all.count).to eq 1
        expect(p.issues.count).to eq 2
      end
    end # exist panic
  end # POST #create
end # PanicController
