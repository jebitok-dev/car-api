class Favorite < ApplicationRecord
  belongs_to :house

  validate_presence_of :name
end
