require 'rails_helper'

RSpec.describe "Admin::WorkDays", type: :request do
  describe "GET /admin/users/:user_id/work_days" do
    let(:user) { FactoryBot.create(:user) }
    let(:url) { admin_user_work_days_path(user) }

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

  describe 'GET /admin/users/:user_id/work_days/:id' do
    let(:user) { FactoryBot.create(:user) }
    let(:work_day) { FactoryBot.create(:work_day, user: user) }
    let(:url) { admin_user_work_day_path(user, work_day) }

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

        context "when work day id is passed as parameter" do
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

        context "when day in YYYY-MM-DD format is passed as parameter" do
          before do
            get admin_user_work_day_path(user, work_day.day.strftime), headers: request_auth_headers(admin)
          end
  
          it 'returns ok status' do
            expect(response).to have_http_status(200)
          end
  
          it 'returns json document' do
            expect(response.content_type).to eq("application/json")
          end

          it 'returns work day corresponding to the specified date' do
            data = JSON.parse(response.body)
            expect(data["day"]).to eq(work_day.day.strftime)
          end
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

  describe "POST /admin/users/:user_id/work_days" do
    let(:user) { FactoryBot.create(:user) }
    let(:work_day_attributes) { FactoryBot.attributes_for(:work_day) }
    let(:url) { admin_user_work_days_path(user) }
    

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
          post url, headers: request_auth_headers(admin), params: { work_day: work_day_attributes }.to_json
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

  describe 'PATCH /admin/users/:user_id/work_days/:id' do
    let(:user) { FactoryBot.create(:user) }
    let(:work_day) { FactoryBot.create(:work_day, user: user) }
    let(:work_day_attributes) { FactoryBot.attributes_for(:work_day) }
    let(:url) { admin_user_work_day_path(user, work_day) }

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

        context "when work day id is passed as parameter" do
          before do
            patch url, headers: request_auth_headers(admin), params: { work_day: work_day_attributes }.to_json
          end
  
          it 'returns ok status' do
            expect(response).to have_http_status(200)
          end
  
          it 'returns json document' do
            expect(response.content_type).to eq("application/json")
          end
        end

        context "when day in YYYY-MM-DD format is passed as parameter" do
          before do
            patch admin_user_work_day_path(user, work_day.day.strftime),
              headers: request_auth_headers(admin),
              params: { work_day: work_day_attributes }.to_json
          end
  
          it 'returns ok status' do
            expect(response).to have_http_status(200)
          end
  
          it 'returns json document' do
            expect(response.content_type).to eq("application/json")
          end

          it 'returns work day corresponding to the specified date' do
            data = JSON.parse(response.body)
            expect(data["day"]).to eq(work_day_attributes[:day])
          end
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


  describe 'DELETE /admin/users/:user_id/work_days/:id' do
    let(:user) { FactoryBot.create(:user) }
    let(:work_day) { FactoryBot.create(:work_day, user: user) }
    let(:url) { admin_user_work_day_path(user, work_day) }

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

        context "when work day id is passed as parameter" do
          before do
            delete url, headers: request_auth_headers(admin)
          end
  
          it 'returns no content status' do
            expect(response).to have_http_status(204)
          end
        end

        context "when day in YYYY-MM-DD format is passed as parameter" do
          before do
            delete admin_user_work_day_path(user, work_day.day.strftime), headers: request_auth_headers(admin)
          end

          it 'returns no content status' do
            expect(response).to have_http_status(204)
          end
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
