class Idea < ActiveRecord::Base

  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  belongs_to :user

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

  def liked_by?(user)
    like_for(user).present?
  end

  def like_for(user)
    likes.find_by_user_id(user.id)
  end

end
