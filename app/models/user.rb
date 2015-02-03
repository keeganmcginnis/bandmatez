class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :statuses
  has_many :user_friendships
  has_many :friends, through: :user_friendships

  validates :profile_name, presence: true

  def full_name
    first_name + " " + last_name
  end

  def to_param
    profile_name
  end  

  def steam_link
    "http://steamcommunity.com/id/#{self.steam_username}"
  end
end
