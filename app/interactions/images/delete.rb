module Images
  class Delete < BaseInteraction
    integer :id

    def execute
      image = current_user.images.find(id)
      if image
        LeaderboardI::Delete.run(image_id: image.id)
        image.destroy
      end
    end
  end
end