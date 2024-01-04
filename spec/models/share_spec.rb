require 'rails_helper'

RSpec.describe Share, type: :model do
  describe 'associations' do
    it 'belongs to post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq :has_many
      expect(association.options[:as]).to eq :commentable
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many likes' do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq :has_many
      expect(association.options[:as]).to eq :likeable
      expect(association.options[:dependent]).to eq :destroy
    end
  end
end
