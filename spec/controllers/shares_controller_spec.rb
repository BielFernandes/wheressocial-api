require 'rails_helper'

RSpec.describe Api::V1::SharesController, :type => :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = create(:user)
    @auth_headers = @user.create_new_auth_token
    request.headers.merge!(@auth_headers)
  end

  let(:mocked_post) { create(:post, user_id: @user.id) }

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
    let(:post_author) { create(:user) }
    let(:post) { create(:post, user_id: post_author.id) }
    let(:share) { create(:share, user_id: @user.id, post_id: post.id) }

    it "should return the post details" do
      get :show, params: { id: share.id }
      expect(response).to have_http_status(200)
    end

    it "should return the correct post according to the parameter" do
      get :show, params: { id: share.id }
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(share.id)
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
    it "creates a new share" do
      post :create, params: { post_id: mocked_post.id, share: params }, format: :json

      expect(response).to have_http_status(:created)
      expect(Share.last.content).to eq('Some content')
    end

    it "should return a specific status code for empty content upon creation." do
      post :create, params: { post_id: mocked_post.id, share: { content: '' } }, format: :json
      expect(response).to have_http_status(:created)
    end

    context "PUT #update" do
    it "should update share info" do
      share = create(:share, post_id: mocked_post.id, content: 'ajusdaun', user_id: @user.id)
      params = { content: "Update my post" }
      put :update, params: { id: share.id, share: params }
      share.reload
      expect(share.content == params[:content])
    end

    it "should a status :unauthorized if the update is from a user who is not the post author" do
      new_user = create(:user)
      share = create(:share, post_id: mocked_post.id, content: 'My Share', user_id: new_user.id)
      params = { content: "Update my post" }
      put :update, params: { id: share.id, share: params }
      share.reload
      expect(response).to have_http_status(:unauthorized)
    end
  end

    context "DELETE #destroy" do
    it "should dele post" do
      share = create(:share, post_id: mocked_post.id, content: 'My Share', user_id: @user.id)
      delete :destroy, params: { id: share.id }
      expect(response).to have_http_status(:success)
    end

    it "should a status :unauthorized if the delete is from a user who is not the post author" do
      new_user = create(:user)
      share = create(:share, post_id: mocked_post.id, content: 'My Share', user_id: new_user.id)
      delete :destroy, params: { id: share.id }
      share.reload
      expect(response).to have_http_status(:unauthorized)
    end
    end
  end
end