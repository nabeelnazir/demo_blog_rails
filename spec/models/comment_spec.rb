require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Validations' do

    let(:user) { User.new(email: "samjones@email.com", password: "ABC", password_confirmation: "ABC") }
    let(:post) { Post.new(title: "title", content: "comment") }

    it 'should create a Comment if all of the validations are true' do
      @comment = Comment.new(name: 'ABC', comment: 'ABC', user: user, post: post)
      @comment.valid?
      expect(@comment.errors).not_to include("can\'t be blank")
    end
  
    it 'should not create a Comment if their title is missing' do
      @comment = Comment.new(comment: "ABCDEF", user: user, post: post)
      @comment.valid?
      expect(@comment.errors[:name]).to include("can\'t be blank")
    end

    it 'should not create a Comment if their comment is missing' do
      @comment = Comment.new(name: "ABCDEF", user: user, post: post)
      @comment.valid?
      expect(@comment.errors[:comment]).to include("can\'t be blank")
    end

    it 'should not create a Comment if their user is missing' do
      @comment = Comment.new(name: "ABCDEF", comment: "ABCDEDFEBB", post: post)
      @comment.valid?
      expect(@comment.errors[:user]).to include("must exist")
    end

    it 'should not create a Comment if their post is missing' do
      @comment = Comment.new(name: "ABCDEF", comment: "ABCDEDFEBB", user: user)
      @comment.valid?
      expect(@comment.errors[:post]).to include("must exist")
    end
  end
end