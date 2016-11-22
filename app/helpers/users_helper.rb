module UsersHelper
  
  def avatar_for(user)
    if user.avatar.present?
      image_tag(user.avatar, alt: user.name, :class => "avatar")
    else
      image_tag("rails.png", alt: user.name, :class => "avatar")
    end
  end
end
