require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe 'associations' do
    it 'belongs to follower' do
      association = described_class.reflect_on_association(:follower)
      expect(association.macro).to eq :belongs_to
      expect(association.options[:class_name]).to eq 'User'
      expect(association.options[:foreign_key]).to eq 'follower_id'
    end

    it 'belongs to followed' do
      association = described_class.reflect_on_association(:followed)
      expect(association.macro).to eq :belongs_to
      expect(association.options[:class_name]).to eq 'User'
      expect(association.options[:foreign_key]).to eq 'followed_id'
    end
  end
end
