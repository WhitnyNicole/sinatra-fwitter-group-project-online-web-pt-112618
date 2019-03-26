class User < ActiveRecord::Base 
  has_many :tweets
  has_secure_password
  
  validates :username, :email, presence: true
  
  def slug
    # self.username.split.join('-')
    self.username.gsub(' ', '-')
  end

  def self.find_by_slug(str)
    find_by(username: str.gsub('-', ' ')) 
  end
end 