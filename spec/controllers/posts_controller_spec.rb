require "rails_helper"

RSpec.describe PostsController, type: :controller do
  describe "GET /" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = User.create(email: "nabeelnazit@abc.com", password: "password", password_confirmation: "password")
      sign_in user
      Post.create(title: "abc@email.com", content: "ABC", user: user)
      Post.last.comments.create(name: "ABCDEF", user: user, post: Post.last)
    end

    after(:each) do
      Post.destroy_all
      User.destroy_all
    end

    it "should return 200:OK" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "creates a Widget" do
      post :create, :params => { :post => {:title => "My Widget", content: "ABC"} }
      expect(response).to redirect_to(post_path(Post.last))
    end

    it "test post show method" do
      Post.last.destroy
      expect(Post.all.count).to eq(0)
    end

  end
end