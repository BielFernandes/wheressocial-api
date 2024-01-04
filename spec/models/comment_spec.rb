require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it 'belongs to commentable' do
      association = described_class.reflect_on_association(:commentable)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end
  end
end
