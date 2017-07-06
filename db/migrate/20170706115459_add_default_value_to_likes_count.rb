class AddDefaultValueToLikesCount < ActiveRecord::Migration[5.1]
  def change
    change_column :images, :likes_count, :integer, default: 0
  end
end
