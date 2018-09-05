class User < ApplicationRecord
  before_save do
    self.first_name = first_name.downcase.capitalize
    self.last_name = first_name.downcase.capitalize
  end
  validates :email, presence: true ,format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i},
            uniqueness: {case_sensitive: false}
  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

end