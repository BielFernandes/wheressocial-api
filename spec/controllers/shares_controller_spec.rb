require 'rails_helper'

RSpec.describe Api::V1::PostsController, :type => :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = create(:user)
    @auth_headers = @user.create_new_auth_token
    request.headers.merge!(@auth_headers)
  end
  let(:post_author)  { create(:user) }
  let(:post) { create(:post, user_id: post_author.id) }
  let(:share) { create(:share, user_id: @user.id, post_id: post.id) }

  context "GET #index" do
    it "should success and render all posts json" do
      get :index
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
    end

    it "should array empty" do
      get :index
      json_response = JSON.parse(response.body)
      expect(json_response).not_to be_nil
    end

    it "should have one post" do
      get :index
      json_response = JSON.parse(response.body)
      expect(json_response).not_to be_nil
    end
  end
end