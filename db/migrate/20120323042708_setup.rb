class Setup < ActiveRecord::Migration
  def change
    create_table "articles", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "title"
      t.text     "body"
      t.integer  "user_id"
    end

    create_table "users", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "email"
      t.string   "password_hash"
    end

    add_index "users", ["email"], :name => "index_users_on_email", :unique => true

    execute "ALTER TABLE articles ADD FOREIGN KEY (user_id) REFERENCES users(id)"
  end
end
