require 'rails_helper'

RSpec.describe Movie, type: :model do
  it 'should be created' do
    expect(create(:movie)).to be_valid
  end

  let(:mv) { build(:movie) }

  it 'should not have duplicates' do
    mv.save
    expect(build(:movie)).to_not be_valid
  end

  it 'should be found in database' do
    mv.save
    expect(Movie.first).to eq(mv)
  end

  it 'should have rating updated' do
    mv.save
    Movie.first.update_attribute(:rating, 3.5)
    expect(Movie.first.rating).to eq(3.5)
  end

  it 'should be deleted' do
    mv.save
    Movie.first.destroy
    expect(Movie.first).to eq(nil)
  end

  it 'should have many comments' do
    expect(Movie.reflect_on_association(:comments).macro).to eq :has_many
  end
end
