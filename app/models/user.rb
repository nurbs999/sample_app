class User < ApplicationRecord
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
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : Bcryp::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
