require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "associations" do
    it "belongs to a user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it "has many comments dependent on destroy" do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
      expect(association.options).to include(dependent: :destroy)
    end

    it "has many likes dependent on destroy" do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq(:has_many)
      expect(association.options).to include(dependent: :destroy)
    end

    it "has many shares dependent on destroy" do
      association = described_class.reflect_on_association(:shares)
      expect(association.macro).to eq(:has_many)
      expect(association.options).to include(dependent: :destroy)
    end
  end

  describe "validations" do
    it "validates presence of user_id" do
      post = Post.new
      post.valid?
      expect(post.errors[:user_id]).to include("can't be blank")
    end

    it "validates content length is at least 0" do
      post = Post.new(content: "Test content")
      post.valid?
      expect(post.errors[:content]).to be_empty
    end
  end
end
