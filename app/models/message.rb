class Message < ActiveRecord::Base
  attr_accessible :message_type, :content, :message, :name, :isMine, :message_date, :message_time
  belongs_to :chat

  # Message Type Defined in config/initializers/chat_type.rb
  

end
