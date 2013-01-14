class Quote
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  #=== Fields
  field :title, type: String
  field :content, type: String
 

  attr_accessible :title, :content

  has_many :comments
  belongs_to :chat
  belongs_to :user
end
