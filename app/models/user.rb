class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :chats, :inverse_of => :user
  has_many :quotes
  has_many :comments

  has_and_belongs_to_many :readable_chats, :class_name => "Chat", :join_table => "users_readable_chats"

end
