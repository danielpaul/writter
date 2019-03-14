class Article < ApplicationRecord
  belongs_to :user
  include Commentable
  has_many :comments, as: :commentable

  validates :title, :text, :user_id, presence: true

  after_create :send_first_article_email


  def send_first_article_email
    if user.articles.count == 1
      ArticlesMailer.first_article(self.id).deliver_later
    end
  end
end
