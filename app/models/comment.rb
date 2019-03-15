class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  validates :body, :user_id, presence: true
  validates_length_of :body, maximum: 1000, allow_blank: false
end
