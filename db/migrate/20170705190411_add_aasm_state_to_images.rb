class AddAasmStateToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :aasm_state, :string, default: :uploaded
  end
end
