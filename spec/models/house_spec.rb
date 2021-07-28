require 'rails_helper'

RSpec.describe House, type: :model do
  it{should have_many(:favorites).dependent(:destroy) }

  it{should validate_presence_of(:title)}
  it{should validate_presence_of(:created_by)}
end
