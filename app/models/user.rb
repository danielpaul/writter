class User < ApplicationRecord
  acts_as_voter

  has_many :articles, dependent: :destroy
  has_many :publications, dependent: :destroy
  has_many :comments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable, :confirmable, :trackable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :email, :username , presence: true
  validates :username, :email, uniqueness: {case_sensitive: false}


  def full_name
    "#{first_name} #{last_name}"
  end

  def avatar_url
    gravatar_id = Digest::MD5.hexdigest(self.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?d=mp"
  end

end
