class RenameColumnPid < ActiveRecord::Migration[5.1]
  def change
    rename_column :comments, :pid, :parent_id
  end
end
