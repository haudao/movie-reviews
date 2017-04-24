require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should be created' do
    expect(create(:user)).to be_valid
    expect(create(:user3)).to be_valid
  end

  it 'should not be created' do
    create(:user)
    expect(build(:user1)).to_not be_valid
    expect(build(:user2)).to_not be_valid
  end
end
