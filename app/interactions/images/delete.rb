module Images
  class Delete < ActiveInteraction::Base
    integer :id
    object :current_user,
           class: User,
           default: nil

    def execute
      image = current_user.images.find_by(id: id)
      return unless image

      LB.remove_member(image.id)
      image.destroy
    end
  end
end
