require 'rails_helper'

RSpec.describe WorkDay, type: :model do
  describe 'validations' do
    let(:work_day) { FactoryBot.build(:work_day) }

    it 'has a valid factory' do
      expect(work_day).to be_valid
    end

    it 'has an invalid factory' do
      expect(FactoryBot.build(:invalid_work_day)).not_to be_valid
    end

    context 'when adding same day twice for same user' do
      let(:work_day) { FactoryBot.create(:work_day) }

      it 'raises a validation error' do
        duplicated_work_day = FactoryBot.build(:work_day, day: work_day.day, user: work_day.user)
        expect(duplicated_work_day).not_to be_valid
      end
    end

    context 'when arrived_at has a date different than day attribute' do
      it 'raises a validationerror' do
        work_day.arrived_at = work_day.day - 1.day
        expect(work_day).not_to be_valid
      end
    end

    context 'when left_at has a date different than day attribute' do
      it 'raises a validation error' do
        work_day.left_at = work_day.day - 1.day
        expect(work_day).not_to be_valid
      end
    end

    context 'when left_at is before arrived_at' do
      it 'raises a validation error' do
        work_day.left_at = work_day.arrived_at - 1.hour
        expect(work_day).not_to be_valid
      end
    end
  end
end
