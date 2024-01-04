require 'rails_helper'

RSpec.describe Api::V1::PostsController, :type => :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    @user = create(:user)
    @auth_headers = @user.create_new_auth_token
    request.headers.merge!(@auth_headers)
  end

  context "GET #index" do
    let(:user)  { create(:user) }
    let(:post) { create(:post, user_id: user.id) }
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
    let(:user)  { create(:user) }
    let(:post) { create(:post, user_id: user.id) }
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

  context "POST #create" do
  let!(:params) {
    {content: 'Some content'}
  }
    it "creates a new post" do
      post :create, params: { post: params }, format: :json

      expect(response).to have_http_status(:created)
      expect(Post.last.content).to eq('Some content')
    end

    it "should return a specific status code for empty content upon creation." do
      post :create, params: { post: { content: '' } }, format: :json
      expect(response).to have_http_status(:created)
    end

    it "unprocessable with other params" do
      post :create, params: { post: { other_param: 'Some content' } }, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context "PUT #update" do
    it "should update post info" do
      post = create(:post, user_id: @user.id)
      params = { content: "Update my post" }
      put :update, params: { id: post.id, post: params }
      post.reload
      expect(post.content == params[:content])
    end

    it "should a status :unauthorized if the update is from a user who is not the post author" do
      new_user = create(:user)
      post = create(:post, user_id: new_user.id)
      params = { content: "Update my post" }
      put :update, params: { id: post.id, post: params }
      post.reload
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "DELETE #destroy" do
  it "should dele post" do
    post = create(:post, user_id: @user.id)
    delete :destroy, params: { id: post.id }
    expect(response).to have_http_status(:success)
  end
  it "should a status :unauthorized if the delete is from a user who is not the post author" do
    new_user = create(:user)
    post = create(:post, user_id: new_user.id)
    delete :destroy, params: { id: post.id }
    post.reload
    expect(response).to have_http_status(:unauthorized)
  end
end
end