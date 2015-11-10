class User < ActiveRecord::Base
  has_many :posts
  has_many :users, through: :posts
  
  has_many :friendships
  has_many :users, through: :friendships
end
