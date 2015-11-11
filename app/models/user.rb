class User < ActiveRecord::Base
  has_many :posts
  has_many :users, through: :posts
  
  has_many :friendships
  has_many :users, through: :friendships
  
  validates :f_name, presence: true
  validates :gender, presence: true
  validates :profile_picture, presence: true
  validates :year_of_birth, numericality: true
  
  has_and_belongs_to_many :posts
  has_and_belongs_to_many :comments
end
