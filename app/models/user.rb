class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true

  has_secure_password

  before_create :create_api_key

  private

  def create_api_key
    self.api_key = SecureRandom.hex(13)
  end
end
