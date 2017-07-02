class AddIndexesToHierarhy < ActiveRecord::Migration[5.1]
  def change
    add_index :comment_hierarchies, [:ancestor_id, :descendant_id, :generations],
              :unique => true, :name => "comment_anc_desc_udx"

    # For "all ancestors of…" selects,
    add_index :comment_hierarchies, [:descendant_id],
              :name => "comment_desc_idx"
  end
end
