class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def repos
    repo = GithubService.new
    repo.github_info("repos", github_token)
  end

  def followers
    follower = GithubService.new
    follower.github_info("followers", github_token)
  end

  def following
    following = GithubService.new
    following.github_info("following", github_token)
  end
end
