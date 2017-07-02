class RemoveFromUsersColumnVoted < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :voted
  end
end
