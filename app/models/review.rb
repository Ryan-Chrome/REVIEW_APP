class Review < ApplicationRecord
  belongs_to :user
  has_many :review_relationships, dependent: :destroy

  validates :rate, numericality: { less_than_or_equal_to: 5, greater_than_or_equal_to: 1 },
                   presence: true

  validates :content, presence: true, length: { maximum: 500 }

  has_one_attached :image1
  has_one_attached :image2
  has_one_attached :image3
  has_one_attached :image4
  has_one_attached :image5
end
