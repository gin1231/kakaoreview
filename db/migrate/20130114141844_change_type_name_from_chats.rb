class ChangeTypeNameFromChats < ActiveRecord::Migration
  def up
    rename_column :chats, :type, :chat_type
  end

  def down
    rename_column :chats, :chat_type, :type
  end
end
