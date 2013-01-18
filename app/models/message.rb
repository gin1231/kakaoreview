class Message
  include Mongoid::Document

  #=== Fields
  field :message_type, type: Integer
  field :message, type: String
  field :content, type: Integer
  field :name, type: String
  field :isMine, type: Boolean
  field :message_date, type: String
  field :message_time, type: String



  attr_accessible :message_type, :content, :message, :name, :isMine, :message_date, :message_time

  embedded_in :chat

  # Message Type Defined in config/initializers/chat_type.rb
  

end
