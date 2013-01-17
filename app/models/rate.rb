class Rate
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  #=== Fields
  field :like, type: Boolean

 
  embedded_in :quote
  belongs_to :user


  scope :likes, where(:like => true)
  scope :dislikes, where(:like => false)

end
