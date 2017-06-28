class PswdChanges < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :crypted_password, :string, :default => nil, :null => true
    change_column :users, :password_salt, :string, :default => nil, :null => true
  end
end
