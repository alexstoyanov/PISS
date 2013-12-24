class CreateUserTokens < ActiveRecord::Migration
  def change
    create_table :user_tokens do |t|
      t.belongs_to :user
      # SecureRandom.urlsafe_base64(32, false).length => 43
      t.string :token, :limit => 43

      t.timestamps
    end

    add_index :user_tokens, :user_id
    add_index :user_tokens, :token
  end
end
