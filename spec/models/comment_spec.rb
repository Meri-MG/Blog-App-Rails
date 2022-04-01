require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Associations' do
    it { should belong_to(:author).without_validating_presence }
    it { should belong_to(:post).without_validating_presence }
  end
end
