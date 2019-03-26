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
  include Sluggable
  include Commentable

  aasm column: :state, enum: true do
    state :draft, initial: true
    state :published
    state :unlisted
    state :personal


    event :published do
      transitions from: [:draft, :published, :unlisted, :personal], to: :published, after: :send_first_article_email
    end

    event :draft do
      transitions from: [:draft, :published, :unlisted, :personal], to: :draft
    end

    event :personal do
      transitions from: [:draft, :published, :unlisted, :personal], to: :personal
    end

    event :unlisted do
      transitions from: [:draft, :published, :unlisted, :personal], to: :unlisted
    end
  end

  enum state: { draft: 0, published: 1, unlisted: 2, personal: 3 }

  is_impressionable

  acts_as_votable

  belongs_to :user

  validates :title, :text, :user_id, presence: true


  def send_first_article_email
    if user.articles.where(state: :published).count == 1
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
