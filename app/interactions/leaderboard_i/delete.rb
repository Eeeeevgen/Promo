module LeaderboardI
  class Delete < ActiveInteraction::Base
    integer :image_id

    def execute
      LB.remove_member(image_id)
    end
  end
end
