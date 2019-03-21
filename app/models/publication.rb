class Publication < ApplicationRecord
  belongs_to :user
  has_many :roles
  has_many :articles, through: :roles

  validates :title, :description, :user_id, presence: true
end
