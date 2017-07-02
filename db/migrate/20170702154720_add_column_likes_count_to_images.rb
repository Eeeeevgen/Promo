class AddColumnLikesCountToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :likes_count, :integer
  end
end
