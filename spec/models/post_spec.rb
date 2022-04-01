require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'A post', text: 'Post text') }
  # , comments_counter: 3, likes_counter: 1

  before { subject.save }

  describe "Associations" do
    it { should belong_to(:author).without_validating_presence }
  end

  it 'isn\'t valid with characters less than 3' do
    subject.title = 'Be'
    expect(subject).to_not be_valid
  end

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'the likes_counter to be an integer' do
    subject.likes_counter = 3
    expect(subject.likes_counter).to be_integer
  end

  it 'the comments_counter to be an integer' do
    subject.comments_counter = 0
    expect(subject.comments_counter).to be_integer
  end
end
