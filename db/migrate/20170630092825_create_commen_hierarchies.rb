class CreateCommenHierarchies < ActiveRecord::Migration[5.1]
  def change
    create_table :commen_hierarchies do |t|
      t.integer :ancestor_id
      t.integer :descendant_id
      t.integer :generations
    end
  end
end
