require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Nino', photo: 'photo', bio: 'She lives in Georgia', posts_counter: 3) }

  before { subject.save }

  it 'isn\'t valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'the posts_counter to be 3' do
    expect(subject.posts_counter).to be(3)
  end

  it 'the posts_counter to be an integer' do
    expect(subject.posts_counter).to be_integer
  end

  it 'the posts_counter to be greater or equal to zero' do
    subject.posts_counter = nil
    expect(subject).to_not be_valid
  end

  it 'the posts_counter to be greater or equal to zero' do
    subject.posts_counter = -5
    expect(subject).to_not be_valid
  end

  describe 'Should test methods in user model' do
    it 'returns the recent three posts' do
      expect(subject.three_recent_posts).to eq(subject.posts.last(3))
    end
  end
end
