class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {maximum: 50 }
  VALID_EMAIL_REGX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255 }, format: { with: VALID_EMAIL_REGX }, uniqueness: {case_sensitice: false }
  
  has_secure_password
  has_many :microposts
  
  has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  def follow(other_user) #他のユーザーのフォロー
    following_relationships.create(followed_id: other_user.id)
  end
  
  def unfollow(other_user) #フォローしてるユーザーをアンフォロー
    following_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  def following?(other_user) #フォローしているかどうか
    following_users.include?(other_user)
  end
end