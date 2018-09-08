class User < ApplicationRecord


  before_create :create_activation_digest
  attr_accessor :remember_token,:activation_token
  before_save do
    self.first_name = first_name.downcase.capitalize
    self.last_name = last_name.downcase.capitalize
  end
  validates :email, presence: true ,format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i},
            uniqueness: {case_sensitive: false}
  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST
               : BCrypt::Engine.cost
    BCrypt::Password.create(string,cost: cost)
  end

  def authenticated?(attribute,token)
    digest = self.send("#{attribute}_digest")
    if digest
      BCrypt::Password.new(digest) == token
    else
      false
    end
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    self.update_attribute(:activated, true)
    self.update_attribute(:activated_at, Time.zone.now)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest,User.digest(remember_token))
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end