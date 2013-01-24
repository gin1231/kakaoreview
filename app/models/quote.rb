class Quote
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  include Mongoid::Paperclip

  #=== Fields
  field :title, type: String
  field :content, type: String
  field :img_file_name, type: String
  field :img_content_type, type: String
  field :img_file_size, type: Integer
  field :img_updated_at, type: DateTime

  
  attr_accessible :title, :content

  has_mongoid_attached_file :img



  has_many :comments
  belongs_to :chat
  belongs_to :user
  embeds_many :rate
end
