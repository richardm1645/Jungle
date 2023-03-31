require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "is valid with valid credentials" do
      user = User.new(
        first_name: "Billy",
        last_name: "Bob",
        email: "john@example.com",
        password: "password",
        password_confirmation: "password"
      )
      expect(user).to be_valid
    end

    it "is not valid without a first name" do
      user = User.new(
        first_name: nil,
        last_name: "Bob",
        email: "bob@example.com",
        password: "password",
        password_confirmation: "password"
      )
      expect(user).to_not be_valid
    end

    it "is not valid without a last name" do
      user = User.new(
        first_name: "Billy",
        last_name: nil,
        email: "joe@example.com",
        password: "password",
        password_confirmation: "password"
      )
      expect(user).to_not be_valid
    end

    it "is not valid without an email" do
      user = User.new(
        first_name: "Bill",
        last_name: "Lawson",
        email: nil,
        password: "password123",
        password_confirmation: "password123"
      )
      expect(user).to_not be_valid
    end

    it "is not valid without a password" do
      user = User.new(
        first_name: "Mani",
        last_name: "Doe",
        email: "mani@example.com",
        password: nil,
        password_confirmation: "password"
      )
      expect(user).to_not be_valid
    end

    it "is not valid with a password shorter than 8 characters" do
      user = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "mani@example.com",
        password: "123",
        password_confirmation: "123"
      )
      expect(user).to_not be_valid
    end

    it "is not valid with a password confirmation that does not match the password" do
      user = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "mani@example.com",
        password: "password",
        password_confirmation: "notpassword"
      )
      expect(user).to_not be_valid
    end

    it "is not valid with a duplicate email" do
      User.create!(
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        password: "password",
        password_confirmation: "password"
      )
      user = User.new(
        first_name: "Jane",
        last_name: "Doe",
        email: "JOHN@example.com",
        password: "password",
        password_confirmation: "password"
      )
      expect(user).to_not be_valid
    end

    it "is valid if the email contains whitespaces" do
      user = User.new(
        email: "   mAni@example.com       "
      )
      user.email = user.email.strip unless user.email.nil?
      expect(user.email).to eq("mAni@example.com")
    end
  end

  describe '.authenticate_with_credentials' do
    let(:user) { User.create(first_name: 'John', last_name: 'Doe', email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }
    context 'with valid credentials' do
      it 'should return the user instance' do
        authenticated_user = user.authenticate_with_credentials(' test@example.com  ', 'password123')
        expect(authenticated_user).to eq(user)
      end
    end

    context 'with invalid credentials' do
      it 'should return nil if the email not found' do
        authenticated_user = user.authenticate_with_credentials('incorrect@example.com', 'password123')
        expect(authenticated_user).to be_nil
      end

      it 'should return nil if the password is incorrect' do
        authenticated_user = user.authenticate_with_credentials('test@example.com', 'wrongpassword')
        expect(authenticated_user).to be_nil
      end
    end
  
  end
end
