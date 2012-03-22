class ChangeNamesInTweetAndHashTag < ActiveRecord::Migration
  def change
    rename_column :tweets, :body, :tweet
    rename_column :hash_tags, :name, :hash_tag
  end
end
