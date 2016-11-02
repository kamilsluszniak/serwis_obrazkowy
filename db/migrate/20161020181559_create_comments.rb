class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :post, foreign_key: true
      
      t.timestamps
    end
    add_index :comments, [:post_id, :created_at]
  end
end
