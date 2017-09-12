class RemoveColumnRemoteAvatarUrlFromSuer < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :remote_avatar_url
  end
end
