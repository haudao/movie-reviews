require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'should be created' do
    expect(create(:comment)).to be_valid
  end

  let(:cmt) { build(:comment) }

  it 'should be found in the database' do
    cmt.save
    expect(Comment.first).to eq(cmt)
  end

  it 'should be deleted' do
    cmt.save
    Comment.first.destroy
    expect(Comment.first).to eq(nil)
  end

  it 'should belong to a movie' do
    expect(Comment.reflect_on_association(:movie).macro).to eq :belongs_to
  end
end
