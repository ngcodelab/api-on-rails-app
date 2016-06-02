class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_create :generate_unique_auth_token!
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :auth_token, uniqueness: true
  
  
  
  # Generate a unique auth_token. This method randomly generates a token
  # and then checks for a record which has already taken the new token.
  # If there exists a record with the same token, then another token 
  # is generated and the process continues unless a uniq token is found.
  def generate_unique_auth_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end  
end
