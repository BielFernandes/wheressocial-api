require 'rails_helper'

RSpec.describe Api::V1::LikesController, type: :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = create(:user)
    @auth_headers = @user.create_new_auth_token
    request.headers.merge!(@auth_headers)
  end  

  let(:mocked_post) { create(:post, user_id: @user.id) }
  let(:comments_index_url) { "/api/v1/posts/#{mocked_post.id}/comments" }
  let!(:params_post_id) {
    { post_id: mocked_post.id }
  }

  context "GET #index" do
    it "should success and render all comments json" do
      get :index, params: params_post_id
      expect(response).to have_http_status(:success)
    end

    it "should array empty" do
      get :index, params: { post_id: mocked_post.id }
      expect(response).to have_http_status(:success)
      expect(response.body).to eq('[]')
    end

    it "should have one Like" do
      create_like = create(:like, user_id: @user.id, likeable: mocked_post)
      get :index, params: { post_id: mocked_post.id }
      expect(Like.last.id).to eq(create_like.id)
    end
  end

  context "POST #create" do
    let!(:params) {
      {content: 'Some content'}
    }
    it 'creates a new like' do
      post :create, params: { post_id: mocked_post.id, likeable: mocked_post }
      expect(response).to have_http_status(:created)
      response_body = JSON.parse(response.body)
      expect(Like.last.id).to eq(response_body['id'])
    end
  end

  context "DELETE #destroy" do
    it "should delete comment" do
      like = create(:like, user_id: @user.id, likeable: mocked_post)
      delete :destroy, params: { post_id: mocked_post.id, id: like.id }
      expect(response).to have_http_status(:success)
    end

    it "should a status :unauthorized if the delete is from a user who is not the post author" do
      new_user = create(:user)
      like = create(:like, user_id: new_user.id, likeable: mocked_post)
      delete :destroy, params: { post_id:mocked_post.id, id: like.id }
      expect(response).to have_http_status(:unauthorized)
    end
  end
  
end

RSpec.describe Api::V1::LikesController, type: :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = create(:user)
    @auth_headers = @user.create_new_auth_token
    request.headers.merge!(@auth_headers)
  end  

  let(:mocked_post) { create(:post, user_id: @user.id) }
  let(:comments_index_url) { "/api/v1/posts/#{mocked_post.id}/comments" }
  let!(:params_share_id) {
    { post_id: mocked_post.id }
  }
  let(:mocked_share) { create(:share, post_id: mocked_post.id, user_id: @user.id) }

  context "GET #index" do
    it "should success and render all comments json" do
      get :index, params: params_share_id
      expect(response).to have_http_status(:success)
    end

    it "should array empty" do
      get :index, params: { share_id: mocked_share.id }
      expect(response).to have_http_status(:success)
      expect(response.body).to eq('[]')
    end

    it "should have one like" do
      like = create(:like, user_id: @user.id, likeable: mocked_share)
      get :index, params: { share_id: mocked_share.id }
      expect(Like.last.id).to eq(like.id)
    end
  end

  context "POST #create" do
  let!(:params) {
    {content: 'Some content'}
  }
    it 'creates a new like' do
      post :create, params: { share_id: mocked_share.id, likeable: mocked_share }
      expect(response).to have_http_status(:created)
      response_body = JSON.parse(response.body)
      expect(Like.last.id).to eq(response_body['id'])
    end
  end

  context "DELETE #destroy" do
    it "should delete comment" do
      like = create(:like, user_id: @user.id, likeable: mocked_share)
      delete :destroy, params: { share_id: mocked_share.id, id: like.id }
      expect(response).to have_http_status(:success)
    end

    it "should a status :unauthorized if the delete is from a user who is not the post author" do
      new_user = create(:user)
      like = create(:like, user_id: new_user.id, likeable: mocked_share)
      delete :destroy, params: { share_id: mocked_share.id, id: like.id }
      expect(response).to have_http_status(:unauthorized)
    end
  end
  
end