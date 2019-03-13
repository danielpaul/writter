class AdminUser < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable
end
