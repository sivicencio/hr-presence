require 'rails_helper'

RSpec.describe User, type: :model do
  ###############
  # validations #
  ###############
  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it 'has an invalid factory' do
    expect(FactoryBot.build(:invalid_user)).not_to be_valid
  end

  ###########
  # methods #
  ###########
  describe '#report_dates' do
    context 'when user has a report' do
      let(:user) { FactoryBot.create(:user_with_report) }

      it 'returns a hash' do
        expect(user.report_dates).to be_a(Hash)
      end

      it 'includes a start date equal to the start date of the report' do
        expect(user.report_dates[:start_date]).to eq(user.report.start_date)
      end

      it 'includes an end date equal to the end date of the report' do
        expect(user.report_dates[:end_date]).to eq(user.report.end_date)
      end
    end

    context 'when user does not have a report' do
      let(:user) { FactoryBot.create(:user) }

      it 'returns a hash' do
        expect(user.report_dates).to be_a(Hash)
      end

      it 'includes a start date corresponding to one month ago' do
        expect(user.report_dates[:start_date]).to eq(1.month.ago.to_date)
      end

      it 'includes an end date corresponding to present day' do
        expect(user.report_dates[:end_date]).to eq(Date.current)
      end
    end
  end
end
