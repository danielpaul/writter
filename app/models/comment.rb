# == Schema Information
#
# Table name: comments
#
#  id               :bigint(8)        not null, primary key
#  commentable_type :string
#  commentable_id   :integer
#  user_id          :integer
#  body             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  after_commit :create_notifications, on: :create

  validates :body, :user_id, :commentable_type, :commentable_id,  presence: true
  validates_length_of :body, maximum: 1000, allow_blank: false

  def content
    self.body
  end

  def create_notifications
    if self.user != self.commentable.user
      Notification.create do |notification|
        notification.notify_type = 'new_comment'
        notification.actor = self.user
        notification.user = self.commentable.user
        notification.target = self
        notification.second_target = self.commentable
      end
    end
  end
end
