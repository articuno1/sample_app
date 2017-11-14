class User < ApplicationRecord
  before_save{self.email = email.downcase}
  validates :name,  presence: true, length: {maximum: Settings.name.maximum_length}
  validates :email, presence: true, length: {maximum: Settings.email.maximum_length},
    format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.password.minimum_length}
end
