class AddUsersToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :user, foreign_key: true
    add_index :comments, [:user_id, :created_at]
  end
end
