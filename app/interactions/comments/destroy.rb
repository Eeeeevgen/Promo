module Comments
  class Destroy < ActiveInteraction::Base
    integer :comment_id

    def execute
      comment = Comment.find(comment_id)
      if comment.leaf?
        comment.destroy
      else
        comment.destroy
      end
    end
  end
end
