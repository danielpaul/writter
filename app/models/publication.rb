class Publication < ApplicationRecord
  belongs_to :user
  has_many :articles

  validates :title, :description, :user_id, presence: true
end
