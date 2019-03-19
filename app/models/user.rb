class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable, :confirmable, :trackable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :email, presence: true
  validates :username, :email, uniqueness: {case_sensitive: false}
end
