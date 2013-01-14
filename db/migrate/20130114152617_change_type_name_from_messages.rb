class ChangeTypeNameFromMessages < ActiveRecord::Migration
  def up
    rename_column :messages, :type, :message_type
    rename_column :messages, :username, :name
    add_column :messages, :message, :string
    add_column :messages, :isMine, :boolean
    add_column :messages, :message_date, :date
    add_column :messages, :message_time, :time
  end

  def down
    rename_column :messages, :message_type, :type
    rename_column :messages, :name, :username
    remove_column :messages, :message
    remove_column :messages, :isMine
    remove_column :messages, :message_date
    remove_column :messages, :message_time
  end
end
