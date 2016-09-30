class AddUsersVotedToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :users_voted, :text
  end
end
