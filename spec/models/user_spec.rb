# spec/models/user_spec.rb
require 'rails_helper'

# Test suite for User model
RSpec.describe User, type: :model do
  # Association test
  # ensure User model has a 1:m relationship with the Todo model
  it { should have_many(:rooms) }
  it { should have_many(:messages) }
  # Validation tests
  # ensure username and password_digest are present before save
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_uniqueness_of(:username) }
end
