require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  describe "GET /admin/users" do
    let(:url) { admin_users_path }

    context 'when user has signed in' do
      context 'when user has employee role' do
        let(:user) { FactoryBot.create(:user) }

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

        it 'returns an array' do
          data = JSON.parse(response.body)
          expect(data).to be_an(Array)
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

  describe 'GET /admin/users/:id' do
    let(:user) { FactoryBot.create(:user) }
    let(:url) { admin_user_path(user) }

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

  describe "POST /admin/users" do
    let(:user_attributes) { FactoryBot.attributes_for(:user) }
    let(:url) { admin_users_path }

    context 'when user has signed in' do
      context 'when user has employee role' do
        let(:user) { FactoryBot.create(:user) }

        before do
          post url, headers: request_auth_headers(user), params: user_attributes.to_json
        end

        it 'returns forbidden status' do
          expect(response).to have_http_status(403)
        end
      end

      context 'when user has admin role' do
        let(:admin) { FactoryBot.create(:user, role: "admin") }

        before do
          post url, headers: request_auth_headers(admin), params: { user: user_attributes }.to_json
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

  describe 'PATCH /admin/users/:id' do
    let(:user) { FactoryBot.create(:user) }
    let(:user_attributes) { FactoryBot.attributes_for(:user) }
    let(:url) { admin_user_path(user) }

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
          patch url, headers: request_auth_headers(admin), params: { user: user_attributes }.to_json
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


  describe 'DELETE /admin/users/:id' do
    let(:user) { FactoryBot.create(:user) }
    let(:url) { admin_user_path(user) }

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
