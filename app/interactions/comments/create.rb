module Comments
  class Create < ActiveInteraction::Base
    string :text
    string :parent_id, default: nil
    string :image_id
    string :user_id

    def execute
      if parent_id.present?
        parent = Comment.find_by(id: parent_id)
        comment = parent.children.build(inputs)
      else
        comment = Comment.new(inputs)
      end

      comment.save
    end
  end
end
