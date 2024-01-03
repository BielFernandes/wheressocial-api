require 'rails_helper'

RSpec.describe Api::V1::PostsController, :type => :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    @user = create(:user)
    @auth_headers = @user.create_new_auth_token
    request.headers.merge!(@auth_headers)
  end

  let(:user)  { create(:user) }
  let(:post) { create(:post, user_id: user.id) }

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

  context "GET #show" do
    it "should return the post details" do
      get :show, params: { id: post.id }
      expect(response). to have_http_status(:success)
      json_response = JSON.parse(response.body)
    end

    it "should return the correct post according to the parameter" do
      get :show, params: { id: post.id }
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(post.id)
    end

    it "should return 'not found' for a nonexistent post" do
      get :show, params: { id: 999 }
      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:not_found)
    end
  end
end