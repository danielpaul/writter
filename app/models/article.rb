class Article < ApplicationRecord
  include Sluggable
  include Commentable

  is_impressionable

  acts_as_votable

  belongs_to :user
  belongs_to :publication, optional: true

  validates :title, :text, :user_id, presence: true

  after_create :send_first_article_email


  def send_first_article_email
    if user.articles.count == 1
      ArticlesMailer.first_article(self.id).deliver_later
    end
  end

  def to_meta_tags
    {
      title: title,
      description: text.truncate(300),
    }
  end
end
