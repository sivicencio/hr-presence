require 'rails_helper'

RSpec.describe Report, type: :model do
  describe 'validations' do
    it 'has a valid factory' do
      expect(FactoryBot.build(:report)).to be_valid
    end

    it 'has an invalid factory' do
      expect(FactoryBot.build(:invalid_report)).not_to be_valid
    end

    context 'when end_date is before start_date' do
      it 'raises a validation error' do
        report = FactoryBot.build(:report)
        report.end_date = report.start_date - 1.day
        expect(report).not_to be_valid
      end
    end
  end
end
