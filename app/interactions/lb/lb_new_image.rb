require 'active_interaction'
include LbHelper

class LbNewImage < ActiveInteraction::Base
  integer :image_id
  integer :score

  def execute
    lb.rank_member(image_id, score)
  end
end