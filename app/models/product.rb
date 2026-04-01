class Product < ApplicationRecord
  belongs_to :category

  has_many_attached :images
  has_many :reviews, dependent: :destroy

  def average_rating
    reviews.average(:rating)&.round(1)
  end
end