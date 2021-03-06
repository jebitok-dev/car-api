require 'rails_helper'

RSpec.describe Car, type: :model do
  it { should have_many(:favorites) }

  it { should validate_presence_of(:picture) }
  it { should validate_presence_of(:reviews) }
  it { should validate_presence_of(:model) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:name) }
end
