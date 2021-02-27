class User < ApplicationRecord
  has_secure_password

  validates :name,  presence: true
  validates :email, presence: true
  validates :password, presence: true

  has_many :posts
end
