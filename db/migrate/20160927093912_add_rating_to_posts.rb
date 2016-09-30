class AddRatingToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :rating, :integer, :default => 0
  end
end
