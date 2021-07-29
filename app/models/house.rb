class House < ApplicationRecord
  has_many :favorites

  validate_presence_of :title, :created_by
end
