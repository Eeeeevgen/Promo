require 'active_interaction'
include LbHelper

class LbNewImage < ActiveInteraction::Base
  integer :image_id

  def execute
    lb.rank_member(image_id, 0)
  end
end