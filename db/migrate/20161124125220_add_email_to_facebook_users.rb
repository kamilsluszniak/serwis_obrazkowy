class AddEmailToFacebookUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :facebook_users, :email, :string
  end
end
