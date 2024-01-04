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

    it "should have one comment" do
      create_comment = create(:comment, user_id: @user.id, commentable: mocked_post)
      get :index, params: { post_id: mocked_post.id }
      expect(Comment.last.id).to eq(create_comment.id)
    end
  end

  context "GET #show" do
    it "should return the comment details" do
      create_comment = create(:comment, user_id: @user.id, commentable: mocked_post)
      get :show, params: {id: create_comment.id, post_id: mocked_post.id}
      expect(Comment.last.id).to eq(create_comment.id)
    end

    it "should return 'not found' for a nonexistent comment" do
      get :show, params: { id: 9999, post_id: mocked_post.id }
      expect(response).to have_http_status(404)
    end
  end

  context "POST #create" do
  let!(:params) {
    {content: 'Some content'}
  }
    it 'creates a new comment' do
      post :create, params: {comment: { content: 'Some content'} , post_id: mocked_post.id }
      expect(response).to have_http_status(:created)
      response_body = JSON.parse(response.body)
      expect(response_body['content']).to eq('Some content')
    end
  end

  context "DELETE #destroy" do
    it "should delete comment" do
      comment = create(:comment, user_id: @user.id, commentable: mocked_post)
      delete :destroy, params: { post_id: mocked_post.id, id: comment.id }
      expect(response).to have_http_status(:success)
    end

    it "should a status :unauthorized if the delete is from a user who is not the post author" do
      new_user = create(:user)
      comment = create(:comment, user_id: new_user.id, commentable: mocked_post)
      delete :destroy, params: { post_id:mocked_post.id, id: comment.id }
      expect(response).to have_http_status(:unauthorized)
    end
  end
  
end

RSpec.describe Api::V1::CommentsController, type: :controller do
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

    it "should have one comment" do
      create_comment = create(:comment, user_id: @user.id, commentable: mocked_share)
      get :index, params: { share_id: mocked_share.id }
      expect(Comment.last.id).to eq(create_comment.id)
    end
  end

  context "GET #show" do
    it "should return the comment details" do
      create_comment = create(:comment, user_id: @user.id, commentable: mocked_share)
      get :show, params: {id: create_comment.id, share_id: mocked_share.id}
      expect(Comment.last.id).to eq(create_comment.id)
    end

    it "should return 'not found' for a nonexistent comment" do
      get :show, params: { id: 9999, post_id: mocked_share.id }
      expect(response).to have_http_status(404)
    end
  end

  context "POST #create" do
  let!(:params) {
    {content: 'Some content'}
  }
    it 'creates a new comment' do
      post :create, params: {comment: { content: 'Some content'} , share_id: mocked_share.id }
      expect(response).to have_http_status(:created)
      response_body = JSON.parse(response.body)
      expect(response_body['content']).to eq('Some content')
    end
  end

  context "DELETE #destroy" do
    it "should delete comment" do
      comment = create(:comment, user_id: @user.id, commentable: mocked_share)
      delete :destroy, params: { share_id: mocked_share.id, id: comment.id }
      expect(response).to have_http_status(:success)
    end

    it "should a status :unauthorized if the delete is from a user who is not the post author" do
      new_user = create(:user)
      comment = create(:comment, user_id: new_user.id, commentable: mocked_share)
      delete :destroy, params: { share_id: mocked_share.id, id: comment.id }
      expect(response).to have_http_status(:unauthorized)
    end
  end
  
end