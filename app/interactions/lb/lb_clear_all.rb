require 'active_interaction'
include LbHelper

class LbClearAll < ActiveInteraction::Base
  def execute
    lb.remove_members_in_score_range(0, 9999)
  end
end