# frozen_string_literal: true

class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :nickname, presence: true, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  private
  def set_uid
    self[:uid] = self[:email] if self[:uid].blank? && self[:email].present?
  end
  has_many :posts
  has_many :likes
  has_many :comments
  has_many :shares
  has_many :followers, foreign_key: :followed_id, class_name: 'Follow'
  has_many :followeds, foreign_key: :follower_id, class_name: 'Follow'
end
