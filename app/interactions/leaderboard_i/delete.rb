module LeaderboardI
  class Delete < LeaderboardI::BaseInteraction
    integer :image_id

    def execute
      lb.remove_member(image_id)
    end
  end
end