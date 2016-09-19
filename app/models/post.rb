class Post < ApplicationRecord
    validates :content, length: { maximum: 140 }, presence: true
    validates :title, length: {maximum: 80}, presence: true
    validates :attachment, presence: true
    mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
    belongs_to :user
end
