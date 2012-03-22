class AddAncestors < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :count, :default => 0
    end
    remove_column :tweets, :related_count
    rename_column :tweets, :ancestor_id, :group_id
  end
end
