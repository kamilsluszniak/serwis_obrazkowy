class AddDefaultToPostsRatingg < ActiveRecord::Migration[5.0]
  def change
    change_column :posts, :rating, :integer, :default => 0
  end
end
