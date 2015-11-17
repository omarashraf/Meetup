class User < ActiveRecord::Base
  has_many :posts
  has_many :users, through: :posts

  has_many :friendships
  has_many :users, through: :friendships

  validates :f_name, presence: true
  validates :gender, presence: true
  validates :profile_picture, presence: true
  validates :year_of_birth, numericality: true

  validate :year_of_birth_is_valid

  has_and_belongs_to_many :posts
  has_and_belongs_to_many :comments

  has_many :communities, through: :members

  scope :male, -> { where(gender: "Male") }
  scope :female, -> { where(gender: "Female") }

  before_save -> { puts 'Saved Successfully!' }

  def year_of_birth_is_valid
    self.errors.add(:year_of_birth, 'invalid') unless self.year_of_birth <= Date.today.year
  end

  def self.getAllByLocation(location)
    if location.present?
      where(location: location)
    else
      all?
    end
  end

end
