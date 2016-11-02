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
    log_in_as @user
    get new_post_path
    assert_response :success
  end

  test "should create post" do
    assert log_in_as @user
    get new_post_path
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference 'Post.count', 1 do 
      post posts_path, params: { post: { title: "post title", 
                                         content: "content", user_id: @user.id, attachment: picture} }
    end
    
  end
  
  test "should redirect to login when not logged in" do
    get new_post_path
    assert_redirected_to login_path
  end
  
  test "associated posts should be destroyed" do
    @user1 = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
    @user1.save
    assert picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert @user1.posts.create!(content: "Lorem ipsum", title: "title", attachment: picture)
    assert_difference 'Post.count', -1 do
      @user1.destroy
    end
  end
  
  #test "should vote post" do
  #  log_in_as @user
  #  assert post rate_post_path, params: {:id => @post.id, :rate => 1}
  #end

  test "should show post" do
    
  end

  test "should get edit" do
    
  end

  test "should update post" do
    
  end

  test "should destroy post" do
    
  end
    
end
