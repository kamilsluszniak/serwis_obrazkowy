require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @post = Post.new(id: 1, title: "Title", content: "Sample content for testing", user_id: 1)
  end
  
  #test "Post should be valid" do
  #  assert @post.valid?
  #end
  
end
