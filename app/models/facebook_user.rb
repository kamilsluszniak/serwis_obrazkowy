class FacebookUser < ApplicationRecord
    belongs_to :user
  
    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create.tap do |fb_user|
            fb_user.provider = auth.provider
            fb_user.uid = auth.uid
            fb_user.email = auth.info.email
            fb_user.name = auth.info.name
            fb_user.oauth_token = auth.credentials.token
            fb_user.oauth_expires_at = Time.at(auth.credentials.expires_at)
            fb_user.save!
        end
    end
end
