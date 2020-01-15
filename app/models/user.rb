class User < ApplicationRecord
  has_many :articles

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def has?(model)
    p self.id
    p model.user_id
    p self.id == model.user_id
  end
end
