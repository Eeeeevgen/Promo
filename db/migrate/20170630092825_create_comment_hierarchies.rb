class CreateCommentHierarchies < ActiveRecord::Migration[5.1]
  def change
    create_table :comment_hierarchies do |t|
      t.integer :ancestor_id
      t.integer :descendant_id
      t.integer :generations
    end
  end
end
