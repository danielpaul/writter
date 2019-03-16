class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable, :confirmable, :trackable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :username, presence: true
  validates :username, :email, uniqueness: {case_sensitive: false}


  def full_name
    "#{first_name} #{last_name}"
  end

  def avatar_url
    gravatar_id = Digest::MD5::hexdigest(self.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=mp"
  end

end
