require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:ahmed)
    @other_user = users(:archer)
    @post = posts(:one)
  end


  test "should get index" do
    
  end

  test "should get new" do
    get new_post_path
    assert_response :success
  end

  test "should create post" do
    
  end

  test "should show post" do
    
  end

  test "should get edit" do
    
  end

  test "should update post" do
    
  end

  test "should destroy post" do
    
  end
    
end
