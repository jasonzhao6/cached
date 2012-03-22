class AddModel < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps
      t.string :email
      t.string :password_hash
    end
    add_index :users, :email, :unique => true
  end
end
