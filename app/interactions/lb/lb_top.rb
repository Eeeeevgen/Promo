require 'active_interaction'
include LbHelper

class LbTop < ActiveInteraction::Base
  def execute
    # lb.leaders(1)
    lb.top(10)
  end
end