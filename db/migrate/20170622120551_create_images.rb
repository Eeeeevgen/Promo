class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.integer :user_id
      t.string  :image
      t.integer :likes_count, default: 0
      t.string  :aasm_state, default: :uploaded
      t.timestamps
    end
  end
end
