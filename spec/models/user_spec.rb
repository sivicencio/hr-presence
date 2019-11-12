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
end
