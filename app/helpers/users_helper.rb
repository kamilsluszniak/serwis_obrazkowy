module UsersHelper
  
  def avatar_for(user)
    if user.avatar.present?
      image_tag(user.avatar, alt: user.name, :class => "avatar")
    elsif user.facebook_user.present?
      @fb_img = user.koala_fetch_fb_profile_image
      image_tag(@fb_img, alt: user.name, :class => "avatar")
    else
      image_tag("rails.png", alt: user.name, :class => "avatar")
    end
  end
end
