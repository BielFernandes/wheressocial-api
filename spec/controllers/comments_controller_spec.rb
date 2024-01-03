require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = create(:user)
    @auth_headers = @user.create_new_auth_token
    request.headers.merge!(@auth_headers)
  end  

  let(:mocked_post) { create(:post, user_id: @user.id) }
  let(:comments_index_url) { "/api/v1/posts/#{mocked_post.id}/comments" }

  context "GET #index" do
  let!(:params_post_id) {
    { post_id: mocked_post.id }
  }
    it "should success and render all comments json" do
      get :index, params: params_post_id
      expect(response).to have_http_status(:success)
    end

    it "should array empty" do
      get :index, params: { post_id: mocked_post.id }
      expect(response).to have_http_status(:success)
      expect(response.body).to eq('[]')
    end

    it "should have one comment" do
      create_comment = create(:comment, user_id: @user.id, commentable: mocked_post)
      get :index, params: { post_id: mocked_post.id }
      expect(response.body['id'] == create_comment['id'])
    end
  end
  
end