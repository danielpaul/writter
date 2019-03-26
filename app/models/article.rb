# == Schema Information
#
# Table name: articles
#
#  id             :bigint(8)        not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  title          :string           not null
#  text           :string           not null
#  user_id        :bigint(8)
#  hash_id        :string
#  publication_id :bigint(8)
#  privacy        :integer
#

class Article < ApplicationRecord
  include AASM

  aasm do
    state :draft, initial: true
    state :pub, :priv, :unlisted

    event :set_public do
      transitions from: [:draft, :pub, :priv, :unlisted], to: :pub
    end

    event :set_draft do
      transitions from: [:draft, :pub, :priv, :unlisted], to: :draft
    end

    event :set_private do
      transitions from: [:draft, :pub, :priv, :unlisted], to: :priv
    end

    event :set_unlisted do
      transitions from: [:draft, :pub, :priv, :unlisted], to: :unlisted 
    end
  end
  include Sluggable
  include Commentable

  is_impressionable

  acts_as_votable

  belongs_to :user

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
