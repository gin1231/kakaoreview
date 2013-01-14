class Comment
  include Mongoid::Document
  attr_accessible :content
  
  belongs_to :quote
  belongs_to :user
end
