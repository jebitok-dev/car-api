class House < ApplicationRecord
    has_many :favorites, dependent :destroy

    validate_presence_of :title, :created_by
end
