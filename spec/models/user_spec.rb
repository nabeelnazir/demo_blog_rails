require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create a User if all of the validations are true' do
      @user = User.new(email: "samjones@email.com", password: "ABC", password_confirmation: "ABC")
      @user.valid?
      expect(@user.errors).not_to include("can\'t be blank")
    end
  
    it 'should not create a User if their email is missing' do
      @user = User.new(password: "ABCDEF", password_confirmation: "ABCDEF")
      @user.valid?
      expect(@user.errors[:email]).to include("can\'t be blank")
    end

    it 'should not create a User if their email is not unique' do
      @user1 = User.new(email: "sam@gmail.com", password: "ABCDEF", password_confirmation: "ABCDEF")
      @user1.save
      @user2 = User.new( email: "sam@gmail.com", password: "ABCDEF", password_confirmation: "ABCDEF")
      @user2.valid?
      expect(@user2.errors[:email]).to include("has already been taken")
    end
    it 'should not create a User if their passwords do not match' do
      @user = User.new(email: "sam@gmail.com", password: "ABCDEF", password_confirmation: "ABCDEFG")
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("doesn\'t match Password")
    end
    it 'should not create a User if there is no password' do
      @user = User.new(email: "sam@gmail.com")
      @user.valid?
      expect(@user.errors[:password]).to include("can\'t be blank")
    end
    it 'should not create a User if there the password is too short' do
      @user = User.new(email: "sam@gmail.com", password: "ABC", password_confirmation: "ABC")
      @user.valid?
      expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end
end