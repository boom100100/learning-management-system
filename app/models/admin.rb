class Admin < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: { case_sensitive: false, message: 'This username is already taken.' }
  validates :password, confirmation: true

end
