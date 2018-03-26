class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :rooms, foreign_key: :created_by
  has_many :messages, foreign_key: :created_by
  # Validations
  validates_presence_of :username, :password_digest
  validates_uniqueness_of :username
end