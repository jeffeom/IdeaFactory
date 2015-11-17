class User < ActiveRecord::Base
  has_secure_password
  after_initialize :set_defaults

  has_many :ideas, dependent: :nullify
  has_many :comments, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_ideas, through: :likes, source: :idea

  has_many :ideas_comments, through: :ideas, source: :comments

  validates :email, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}".strip
  end

  private

  def set_defaults
    self.join ||= false
  end
end
