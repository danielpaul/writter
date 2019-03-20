class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  after_commit :create_notifications, on: :create

  validates :body, :user_id, :commentable_type, :commentable_id,  presence: true
  validates_length_of :body, maximum: 1000, allow_blank: false

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
