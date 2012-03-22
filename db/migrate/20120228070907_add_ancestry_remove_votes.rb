class AddAncestryRemoveVotes < ActiveRecord::Migration
  def change
    drop_table :votes
    add_column :tweets, :ancestor_id, :integer
  end
end
