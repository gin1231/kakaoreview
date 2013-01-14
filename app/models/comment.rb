class Comment < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :quote
  belongs_to :user
end
