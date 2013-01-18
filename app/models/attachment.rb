class Attachment
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  include Mongoid::Paperclip

  #=== Fields
  field :att_file_name, type: String
  field :att_content_type, type: String
  field :att_file_size, type: Integer
  field :att_updated_at, type: DateTime

  field :att_type, type: Integer



  has_mongoid_attached_file :att


  embedded_in :chat

end
