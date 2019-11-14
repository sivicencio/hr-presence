require 'rails_helper'

RSpec.describe "Reports", type: :request do
  describe "GET /users/report" do
    let(:user) { FactoryBot.create(:user) }
    let(:url) { '/users/report' }
    
    context 'when user has signed in' do
      before do  
        get url, headers: request_auth_headers(user)
      end

      it 'returns ok status' do
        expect(response).to have_http_status(200)
      end

      it 'returns json document' do
        expect(response.content_type).to eq("application/json")
      end
      
      context 'when user has a report' do
        context 'when user has work days data' do
          let(:user) { FactoryBot.create(:user_with_work_days_and_report) }

          before do  
            get url, headers: request_auth_headers(user)
            @data = JSON.parse(response.body)
          end

          it 'returns an array with data' do
            expect(@data).to be_an(Array)
            expect(@data).not_to be_empty
          end

          describe 'report data' do
            it 'starts with the start date of the report' do
              expect(@data.first["day"]).to eq(user.report.start_date.strftime)
            end
  
            it 'ends with the end date of the report' do
              expect(@data.last["day"]).to eq(user.report.end_date.strftime)
            end
          end
        end


        context 'when user does not have work days data' do
          let(:user) { FactoryBot.create(:user_with_report) }

          before do  
            get url, headers: request_auth_headers(user)
            @data = JSON.parse(response.body)
          end

          it 'returns an empty array' do
            expect(@data).to be_an(Array)
            expect(@data).to be_empty
          end
        end
      end

      context 'when user does not have a report' do
        context 'when user has work days data' do
          let(:user) { FactoryBot.create(:user_with_work_days) }

          before do  
            get url, headers: request_auth_headers(user)
            @data = JSON.parse(response.body)
          end

          it 'returns an array with data' do
            expect(@data).to be_an(Array)
            expect(@data).not_to be_empty
          end

          describe 'report data' do
            it 'starts with a date corresponding to one month ago' do
              expect(@data.first["day"]).to eq(1.month.ago.to_date.strftime)
            end
  
            it 'ends with a date corresponding to present day' do
              expect(@data.last["day"]).to eq(Date.current.strftime)
            end
          end
        end

        context 'when user does not have work days data' do
          before do  
            get url, headers: request_auth_headers(user)
            @data = JSON.parse(response.body)
          end
          
          it 'returns an empty array' do
            expect(@data).to be_an(Array)
            expect(@data).to be_empty
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
end
