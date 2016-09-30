class AddDefaultToUsersVotedd < ActiveRecord::Migration[5.0]
  def change
    change_column :posts, :users_voted, :text, :default => " "
  end
end
