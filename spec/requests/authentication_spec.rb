require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  describe "POST /users/sign_in" do
    let(:user) { FactoryBot.create(:user) }
    let(:url) { '/users/sign_in' }

    let(:params) do
      {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    context 'when sign in params are valid' do
      before do
        post url, params: params
      end

      it 'returns ok status' do
        expect(response).to have_http_status(200)
      end

      it 'includes JWT token in Authorization header' do
        expect(response.headers['Authorization']).to be_present
      end
    end

    context 'when sign in params are invalid' do
      before do
        post url
      end

      it 'returns unauthorized status' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE /users/sign_out" do
    let(:url) { '/users/sign_out' }

    before do
      delete url
    end

    it 'returns no content status' do      
      expect(response).to have_http_status(204)
    end
  end
end
