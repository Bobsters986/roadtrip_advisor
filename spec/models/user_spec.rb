require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
    it { should have_secure_password }
  end

  describe 'Password encryption' do
    it 'encrypts the password using BCrypt' do
      user = User.create(email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')
        expect(user).to_not have_attribute(:password)
        expect(user).to_not have_attribute(:password_confirmation)
        expect(user.password_digest).to_not be_nil
        expect(user.password_digest).to_not eq('password123')
    end
  end
end
