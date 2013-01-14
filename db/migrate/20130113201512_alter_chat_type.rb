class AlterChatType < ActiveRecord::Migration
  def change
    add_column :chats, :type, :integer
  end
end
