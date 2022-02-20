require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations' do

    let(:user) { User.new(email: "samjones@email.com", password: "ABC", password_confirmation: "ABC") }

    it 'should create a Post if all of the validations are true' do
      @post = Post.new(title: "samjones@email.com", content: "ABC", user: user)
      @post.valid?
      expect(@post.errors).not_to include("can\'t be blank")
    end
  
    it 'should not create a Post if their title is missing' do
      @post = Post.new(content: "ABCDEF", user: user)
      @post.valid?
      expect(@post.errors[:title]).to include("can\'t be blank")
    end

    it 'should not create a Post if their content is missing' do
      @post = Post.new(title: "ABCDEF", user: user)
      @post.valid?
      expect(@post.errors[:content]).to include("can\'t be blank")
    end

    it 'should not create a Post if their user is missing' do
      @post = Post.new(title: "ABCDEF", title: "ABCDEDFEBB")
      @post.valid?
      expect(@post.errors[:content]).to include("can\'t be blank")
    end
  end
end