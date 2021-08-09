class User < ApplicationRecord
  has_secure_password

  has_many :favorites 
  has_many :cars, through: :favorites

  validates_presence_of :name, :email, :password_digest
end
