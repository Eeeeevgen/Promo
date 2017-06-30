class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :image_id
      t.integer :pid

      t.timestamps
    end
  end
end
