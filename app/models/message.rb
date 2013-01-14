class Message
  include Mongoid::Document
  # attr_accessible :title, :body
  belongs_to :chat

  INVITATION = 1
  MESSAGE = 2

  
end
