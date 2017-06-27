class Droppicturetable < ActiveRecord::Migration[5.1]
  def down
    drop_table :pictures
  end
end
