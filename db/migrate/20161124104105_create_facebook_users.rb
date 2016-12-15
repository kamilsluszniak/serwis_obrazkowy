class CreateFacebookUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :facebook_users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
