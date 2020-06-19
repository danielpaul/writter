class Publication < ApplicationRecord

  has_many :publications_users
  has_many :users, through: :publications_users
  has_many :articles

  validates :title, :description, presence: true
end
