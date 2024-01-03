require 'rails_helper'

RSpec.describe Api::V1::FollowsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = create(:user)
    @auth_headers = @user.create_new_auth_token
    request.headers.merge!(@auth_headers)
  end
  let!(:mock_user) { create(:user) }
  let!(:params_user_id) {
    { user_id: mock_user.id }
  }

  context "GET #user_followed" do
    it "should success and render all comments json" do
      create_follow = create(:follow, follower_id: @user.id, followed_id: mock_user.id)
      get :user_followed, params: params_user_id
      expect(response).to have_http_status(:success)
    end

    it "should array empty" do
      create_follow = create(:follow, follower_id: @user.id, followed_id: mock_user.id)
      get :user_followers, params: params_user_id
      expect(response).to have_http_status(:success)
    end

    it "should have one follower" do
      create_follow = create(:follow, follower_id: @user.id, followed_id: mock_user.id)
      get :user_followers, params: params_user_id
      expect(Follow.last.followed_id).to eq(create_follow.followed_id)
      expect(Follow.last.follower_id).to eq(create_follow.follower_id)
    end

  end

  context "POST #create" do
    it "return error if the user tries to follow themselves" do
      post :create, params: { user_id: @user.id, follower_id: @user.id }
      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json_response["message"]).to eq("You cannot follow this action")
    end

    it "creates a new follow" do
      post :create, params: { user_id: mock_user.id, follower_id: @user.id }
      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(Follow.last.follower_id).to equal(@user.id)
    end
  end

  context "DELETE #destroy" do
    it "teste" do
      create_follow = create(:follow, follower_id: @user.id, followed_id: mock_user.id)
      delete :destroy, params: { user_id: mock_user.id, follower_id: @user.id }
      expect(response).to have_http_status(:no_content)
      json_response = JSON.parse(response.body)
    end
  end
  
end