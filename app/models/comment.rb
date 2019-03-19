class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  validates :body, :user_id, :commentable_type, :commentable_id,  presence: true
  validates_length_of :body, maximum: 1000, allow_blank: false
end
