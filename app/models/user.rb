class User < ApplicationRecord
  has_many :bills, dependent: :destroy

  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true
  validates :password, presence: true
end