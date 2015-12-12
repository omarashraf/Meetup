class Comment < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :posts

  validates :content, presence: true
end
