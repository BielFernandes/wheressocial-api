require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it 'belongs to likeable' do
      association = described_class.reflect_on_association(:likeable)
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
