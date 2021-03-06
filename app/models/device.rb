class Device < ActiveRecord::Base

  validates :auth_token, uniqueness: true
 
  before_create :generate_authentication_token!

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  belongs_to :user


end
