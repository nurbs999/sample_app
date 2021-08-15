class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.email.downcase! }
  validates :name, presence: true, length: {maximum: 50}
  validates :email, 
              presence: true, 
              length: {maximum: 255}, 
              format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i},
              uniqueness: true
  validates :password, length: {minimum: 6}, presence: true
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #returns a new random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
  end
end
