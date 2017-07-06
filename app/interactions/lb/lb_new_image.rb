require 'active_interaction'
include LbHelper

class LbNewImage < ActiveInteraction::Base
  integer :image_id
  integer :score, default: 0

  def execute
    lb.rank_member(image_id, score)
  end
end