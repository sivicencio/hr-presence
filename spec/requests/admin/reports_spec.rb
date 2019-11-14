require 'rails_helper'

RSpec.describe "Admin::Reports", type: :request do
  describe "GET /admin/users/:user_id/report" do
    let(:user) { FactoryBot.create(:user_with_report) }
    # let(:report) { FactoryBot.create(:report, user: user) }
    let(:url) { admin_user_report_path(user) }

    context 'when user has signed in' do
      context 'when user has employee role' do
        before do
          get url, headers: request_auth_headers(user)
        end

        it 'returns forbidden status' do
          expect(response).to have_http_status(403)
        end
      end

      context 'when user has admin role' do
        let(:admin) { FactoryBot.create(:user, role: "admin") }

        before do
          get url, headers: request_auth_headers(admin)
        end

        it 'returns ok status' do
          expect(response).to have_http_status(200)
        end

        it 'returns json document' do
          expect(response.content_type).to eq("application/json")
        end
      end
    end

    context 'when user has not signed in' do
      before do
        get url
      end

      it 'returns unauthorized status' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "POST /admin/users/:user_id/report" do
    let(:user) { FactoryBot.create(:user) }
    let(:report_attributes) { FactoryBot.attributes_for(:report) }
    let(:url) { admin_user_report_path(user) }

    context 'when user has signed in' do
      context 'when user has employee role' do
        before do
          post url, headers: request_auth_headers(user)
        end

        it 'returns forbidden status' do
          expect(response).to have_http_status(403)
        end
      end

      context 'when user has admin role' do
        let(:admin) { FactoryBot.create(:user, role: "admin") }

        before do
          post url, headers: request_auth_headers(admin), params: { report: report_attributes }.to_json
        end

        it 'returns created status' do
          expect(response).to have_http_status(201)
        end

        it 'returns json document' do
          expect(response.content_type).to eq("application/json")
        end
      end
    end

    context 'when user has not signed in' do
      before do
        post url
      end

      it 'returns unauthorized status' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PATCH /admin/users/:user_id/report' do
    let(:user) { FactoryBot.create(:user_with_report) }
    let(:report_attributes) { FactoryBot.attributes_for(:report) }
    let(:url) { admin_user_report_path(user) }

    context 'when user has signed in' do
      context 'when user has employee role' do
        before do
          patch url, headers: request_auth_headers(user)
        end

        it 'returns forbidden status' do
          expect(response).to have_http_status(403)
        end
      end

      context 'when user has admin role' do
        let(:admin) { FactoryBot.create(:user, role: "admin") }

        before do
          patch url, headers: request_auth_headers(admin), params: { report: report_attributes }.to_json
        end

        it 'returns ok status' do
          expect(response).to have_http_status(200)
        end

        it 'returns json document' do
          expect(response.content_type).to eq("application/json")
        end
      end
    end

    context 'when user has not signed in' do
      before do
        patch url
      end

      it 'returns unauthorized status' do
        expect(response).to have_http_status(401)
      end
    end
  end


  describe 'DELETE /admin/users/:user_id/report' do
    let(:user) { FactoryBot.create(:user_with_report) }
    let(:report) { FactoryBot.create(:report, user: user) }
    let(:url) { admin_user_report_path(user) }

    context 'when user has signed in' do
      context 'when user has employee role' do
        before do
          delete url, headers: request_auth_headers(user)
        end

        it 'returns forbidden status' do
          expect(response).to have_http_status(403)
        end
      end

      context 'when user has admin role' do
        let(:admin) { FactoryBot.create(:user, role: "admin") }

        before do
          delete url, headers: request_auth_headers(admin)
        end

        it 'returns no content status' do
          expect(response).to have_http_status(204)
        end
      end
    end

    context 'when user has not signed in' do
      before do
        delete url
      end

      it 'returns unauthorized status' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
