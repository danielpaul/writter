class Article < ApplicationRecord
  belongs_to :user

  validates :title, :text, :user_id, presence: true
end
