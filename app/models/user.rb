class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {maximum: 50 }
  VALID_EMAIL_REGX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255 }, format: { with: VALID_EMAIL_REGX }, uniqueness: {case_sensitice: false }
  
  has_secure_password
end
