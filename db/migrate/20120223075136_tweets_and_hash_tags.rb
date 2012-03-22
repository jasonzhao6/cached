class TweetsAndHashTags < ActiveRecord::Migration
  def change
    create_table :hash_tags do |t|
      t.string :name
    end

    create_table :tweets do |t|
      t.timestamps
      t.string :body
      t.integer :hash_tag_id
    end

    create_table :votes do |t|
      t.timestamps
      t.boolean :is_positive, :default => true
      t.integer :tweet_id
    end
  end
end
