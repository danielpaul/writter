class PublicationUser < ApplicationRecord
  belongs_to :publication
  belongs_to :user

  enum role: {admin: 0, author: 1}
end
