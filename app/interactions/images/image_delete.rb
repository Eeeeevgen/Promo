require 'active_interaction'
include SessionHelper

class ImageDelete < ActiveInteraction::Base
  integer :id

  def execute
    image = current_user.images.find(id)
    if image
      LbDelete.run(image_id: image.id)
      image.destroy
    end
  end
end