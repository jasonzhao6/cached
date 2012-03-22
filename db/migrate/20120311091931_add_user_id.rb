class AddUserId < ActiveRecord::Migration
  def change
    add_column :tweets, :user_id, :integer
    add_column :hash_tags, :user_id, :integer
    execute "ALTER TABLE tweets ADD FOREIGN KEY (user_id) REFERENCES users(id)"
    execute "ALTER TABLE hash_tags ADD FOREIGN KEY (user_id) REFERENCES users(id)"
  end
end
