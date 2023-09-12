class Bill < ApplicationRecord
  has_many :bill_notifications, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :date, presence: true
end
