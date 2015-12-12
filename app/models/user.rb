class User < ActiveRecord::Base
  # attr_accessible :provider, :uid

  has_many :posts
  has_many :users, through: :posts

  has_many :friendships
  has_many :users, through: :friendships

  validates :f_name, presence: true
  validates :gender, presence: true
  #validates :profile_picture, presence: true
  validates :day, numericality: true
  validates :day, presence: true

  validates :month, numericality: true
  validates :month, presence: true

  validates :year, numericality: true
  validates :year, presence: true

  validates :email, presence: true
  validates :email, uniqueness: true

  validates :password, presence: true

  has_and_belongs_to_many :posts
  has_and_belongs_to_many :comments

  has_many :communities, through: :members

  scope :male, -> { where(gender: "Male") }
  scope :female, -> { where(gender: "Female") }

  before_save -> { puts 'Saved Successfully!' }

  before_create -> { self.token = SecureRandom.hex }, unless: :token?

  def self.getAllByLocation(location)
    if location.present?
      where(location: location)
    else
      all?
    end
  end

  def self.authenticate(email, password)
    user = find_by(email: email)
    if user.present? && user.password == password
      user
    else
      User.new.tap do |user|
        user.errors.add :base, 'Invalid email or password'
      end
    end
  end

  def self.omniauth(auth)
    where(auth.permit(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.f_name = auth.info.name
      user.profile_picture = auth.info.image
      user.fb_token = auth.credentials.token
      user.expires_at = Time.at(auth.credentials.expires_at)
      raise user.inspect
      user.save!
    end
  end
end
