class User < ApplicationRecord

  has_many :microposts , dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
           foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships,
           source: :followed

  has_many :passive_relationships, class_name: "Relationship",
           foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships,
           source: :follower

  before_create :create_activation_digest
  attr_accessor :remember_token,:activation_token, :reset_token
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

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def feed
    following_ids_subselect="SELECT followed_id FROM relationships WHERE follower_id = :id"
    Micropost.where("user_id IN (#{following_ids_subselect}) OR user_id = :id", id: id)
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

  def create_password_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,User.digest(reset_token))
    update_attribute(:reset_sent_at,Time.zone.now)
  end

  def send_reset_password_email
    UserMailer.password_reset(self).deliver_now
  end

  def follow(another_user)
    active_relationships.create(followed_id: another_user.id)
  end

  def following?(another_user)
    !!active_relationships.find_by(followed_id: another_user.id)
  end

  def unfollow(another_user)
    active_relationships.find_by(followed_id: another_user.id).destroy
  end
  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end



end