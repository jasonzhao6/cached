class AddRelatedCount < ActiveRecord::Migration
  def change
    add_column :tweets, :related_count, :integer
  end
end
