class AddRelationsshipsForChatAndUser < ActiveRecord::Migration
  def up
    create_table :users_readable_chats, :id => false do |t|
      t.references :user, :chat
    end
    add_index :users_readable_chats, [:user_id, :chat_id]
  end

  def down
    drop_table :users_readable_chats
    remove_index :users_readable_chats, [:user_id, :chat_id]
  end
end
