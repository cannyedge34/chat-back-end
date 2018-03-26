require 'rails_helper'

RSpec.describe Room, type: :model do
  it { should have_many(:messages).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
