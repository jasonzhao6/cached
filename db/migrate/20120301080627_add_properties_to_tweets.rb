class AddPropertiesToTweets < ActiveRecord::Migration
  def change
    remove_column :tweets, :related_count
    add_column :tweets, :related_count, :integer, :default => 0
    add_index "hash_tags", ["hash_tag"], :unique => true
  end
end
