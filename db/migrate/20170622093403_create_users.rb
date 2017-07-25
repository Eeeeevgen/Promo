class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, unique: true
      t.string :email, unique: true
      t.string :crypted_password, :default => nil, :null => true
      t.string :password_salt, :default => nil, :null => true
      t.string :persistence_token
      t.string :avatar
      t.string :remote_avatar_url
      t.string :token
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
