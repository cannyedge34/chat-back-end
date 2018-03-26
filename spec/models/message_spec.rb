require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should belong_to(:room) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:created_by) }
end
