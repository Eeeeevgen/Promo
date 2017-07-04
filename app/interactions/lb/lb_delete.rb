require 'active_interaction'
include LbHelper

class LbDelete < ActiveInteraction::Base
  integer :image_id

  def execute
    lb.remove_member(image_id)
  end
end