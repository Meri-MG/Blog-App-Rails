require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'A post', text: 'Post text', comments_counter: 3, likes_counter: 1) }

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
    expect(subject.likes_counter).to be_integer
  end

  it 'the comments_counter to be an integer' do
    expect(subject.comments_counter).to be_integer
  end

  it 'the comments_counter to be equal or greater than zero' do
    subject.comments_counter = nil
    expect(subject).to_not be_valid
  end

  it 'the comments_counter to be equal or greater than zero' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  describe 'Should test methods in post model' do
    it 'returns the recent five comments' do
      expect(subject.five_recent_comments).to eq(subject.comments.last(5))
    end
  end
end
