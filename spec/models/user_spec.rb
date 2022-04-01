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

  # it 'the  to be an integer' do
  #   subject.three_recent_posts = 0
  #   expect(subject.posts_counter).to be_integer
  # end

end
