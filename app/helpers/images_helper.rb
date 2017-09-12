module ImagesHelper
  def current_rating(image)
    LB.rank_for(image.id)
  end

  def avatar_thumb_url(id)
    user = User.find(id)
    user.avatar.thumb.url
  end

  def username(id)
    User.find(id).name
  end

  def like_button_style(image)
    if !current_user || image.user.id == current_user.id
      return 'pointer-events: none; opacity: 0.5;'
    end
    if image.likes.find_by(user_id: current_user.id)
      'opacity: 1;'
    else
      'opacity: 0.5;'
    end
  end
end
