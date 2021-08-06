class Car < ApplicationRecord
  has_one_attached :image
  has_many :favorites
  has_many :users, through: :favorites

  validates_presence_of :image, :name, :model, :reviews, :price 
end
