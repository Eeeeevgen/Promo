class AddLikesTo < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :likes, :integer, :default => 0
  end
end
