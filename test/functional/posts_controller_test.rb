require 'test_helper'
require 'active_support/concern'

module PostsControllerBehavior
  extend ActiveSupport::Concern

  included do
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:posts)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create post" do
      assert_difference('Post.count') do
        post :create, post: { body: @post.body, private: @post.private, title: @post.title }
      end

      assert_redirected_to post_path(assigns(:post))
    end

    test "should show post" do
      get :show, id: @post
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @post
      assert_response :success
    end

    test "should update post" do
      put :update, id: @post, post: { body: @post.body, private: @post.private, title: @post.title }
      assert_redirected_to post_path(assigns(:post))
    end

    test "should destroy post" do
      assert_difference('Post.count', -1) do
        delete :destroy, id: @post
      end

      assert_redirected_to posts_path
    end
  end
end

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
  end

  include PostsControllerBehavior

end

class PrivatePostsControllerTest < ActionController::TestCase
  tests PostsController

  setup do
    @post = posts(:two)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("foo","bar")
  end

  include PostsControllerBehavior

end
