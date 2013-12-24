class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :null => false
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :faculty_number
      t.string :type, :null => false
      t.string :password_digest

      t.datetime :password_reset_at
      t.string :password_reset_hash

      t.timestamps
    end

    add_index :users, :email, 		   :unique => true
  end
end
