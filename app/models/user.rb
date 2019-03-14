class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable, :confirmable, :trackable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :username, presence: true
  validates :username, :email, uniqueness: {case_sensitive: false}
end
