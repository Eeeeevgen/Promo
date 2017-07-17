module ImagesHelper
  def current_rating(image)
    LeaderboardI::RankForMember.run!(image_id: image.id)
  end
end