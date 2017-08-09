module Images
  class Delete < ActiveInteraction::Base
    integer :id
    object :current_user,
           class: User,
           default: nil

    def execute
      image = current_user.images.find_by(id: id)
      return unless image

      LeaderboardI::Delete.run(image_id: image.id)
      image.destroy
    end
  end
end
