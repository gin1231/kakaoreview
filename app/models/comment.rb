class Comment
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  #=== Fields
  field :content, type: String


  attr_accessible :content
  
  belongs_to :quote
  belongs_to :user
end
