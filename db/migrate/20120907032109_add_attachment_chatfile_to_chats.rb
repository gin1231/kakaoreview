class AddAttachmentChatfileToChats < ActiveRecord::Migration
  def self.up
    change_table :chats do |t|
      t.has_attached_file :chatfile
    end
  end

  def self.down
    drop_attached_file :chats, :chatfile
  end
end
