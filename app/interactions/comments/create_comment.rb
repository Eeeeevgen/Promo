require 'active_interaction'

class CreateComment < ActiveInteraction::Base
  string :text
  string :parent_id, default: '0'
  string :image_id
  string :user_id

  def execute
    if parent_id.to_i > 0
      parent = Comment.find_by_id(parent_id)
      comment = parent.children.build(inputs)
    else
      comment = Comment.new(inputs)
    end

    comment.save
  end
end