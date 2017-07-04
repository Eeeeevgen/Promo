module ImagesHelper
  def current_rating(image)
    out = LbRankForMember.run!(image_id: image.id)
  end
end