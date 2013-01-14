class Quote
  include Mongoid::Document
  attr_accessible :title, :content

  has_many :comments
  belongs_to :chat
  belongs_to :user
end
