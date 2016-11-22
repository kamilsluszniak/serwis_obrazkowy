class Post < ApplicationRecord
    YT_LINK_FORMAT = /\A(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{11})/
    
    before_create -> do
        if video_link
            yt_uid = video_link.match(YT_LINK_FORMAT)
            self.yt_uid = yt_uid[1] if yt_uid && yt_uid[1]
            if self.yt_uid.to_s.length != 11
                self.errors.add(:video_link, 'Link jest niepoprawny.')
                false
            end
        end
    end
    
    validates :content, length: { maximum: 140 }, presence: true
    validates :title, length: {maximum: 80}, presence: true
    validates :video_link, format: YT_LINK_FORMAT, allow_blank: true
    mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
    belongs_to :user
    has_many :comments, dependent: :destroy
    
end
