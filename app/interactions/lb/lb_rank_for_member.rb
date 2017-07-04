require 'active_interaction'
include LbHelper

class LbRankForMember < ActiveInteraction::Base
  integer :image_id

  def execute
    lb.rank_for(image_id)
  end
end