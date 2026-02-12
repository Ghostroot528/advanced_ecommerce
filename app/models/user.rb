class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders

  # admin? (boolean check) → returns true or false
  def admin?
    admin == true
  end
end
