class Publication < ApplicationRecord
  has_many :roles
  has_many :users, through: :roles
  has_many :articles

  validates :title, :description, presence: true
end
