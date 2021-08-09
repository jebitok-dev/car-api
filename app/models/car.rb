class Car < ApplicationRecord
  has_many :favorites
  has_many :users, through: :favorites

  validates_presence_of :picture, :name, :model, :reviews, :price
end
