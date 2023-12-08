# frozen_string_literal: true

class User < ActiveRecord::Base
  validates :name, presence: true
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
end
