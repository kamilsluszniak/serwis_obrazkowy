class AddYtUidToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :yt_uid, :string
  end
end
