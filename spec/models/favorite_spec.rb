require 'rails_helper'

RSpec.describe Favorite, type: :model do
  it { should belong_to(:house) }

  it { should validate_presence_of(:name) }
end
