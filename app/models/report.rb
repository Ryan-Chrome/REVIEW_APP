class Report < ApplicationRecord
  validates :subject, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 400 }
  validates :user_id, presence: true
  validates :review_id, presence: true

  belongs_to :user
  belongs_to :review
end
