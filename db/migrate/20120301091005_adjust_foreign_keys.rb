class AdjustForeignKeys < ActiveRecord::Migration
  def change
    execute "ALTER TABLE tweets ADD FOREIGN KEY (group_id) REFERENCES groups(id)"
    execute "ALTER TABLE tweets ADD FOREIGN KEY (hash_tag_id) REFERENCES hash_tags(id)"
  end
end
