class AddAttachmentToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :attachment, :string
  end
end
