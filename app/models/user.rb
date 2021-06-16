class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #レビュー
  has_many :reviews, dependent: :destroy

  #ユーザーフォロー
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user

  #レビューお気に入り
  has_many :review_relationships, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  has_one_attached :image

  #follow関連

  def follow(other_user)
    unless self == other_user
      self.relationships.create(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  #レビューお気に入り関連

  def review_like(review)
    unless self == review.user
      self.review_relationships.create(review_id: review.id)
    end
  end

  def review_unlike(review)
    relationship = self.review_relationships.find_by(review_id: review.id)
    relationship.destroy if relationship
  end

  def review_like?(review)
    self.review_relationships.find_by(review_id: review.id)
  end
end
