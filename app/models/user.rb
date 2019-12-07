class User < ApplicationRecord
  has_secure_password

  has_many :articles

  validates :name,
    presence: true,
    uniqueness: true,
    length: { minimum: 8 }
  validates :password,
    presence: true,
    confirmation: true
end
