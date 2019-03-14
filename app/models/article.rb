# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  validates :title, :text, :user_id, presence: true

  after_create :send_first_article_email

  def send_first_article_email
    ArticlesMailer.first_article(id).deliver_later if user.articles.count == 1
  end
end
