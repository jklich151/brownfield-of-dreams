class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def repos
    get_repos = GithubSearch.new("repos", github_token)
    get_repos.repos
  end
  
  def following
    get_following = GithubSearch.new("following", github_token)
    get_following.following
  end

  def followers
    get_followers = GithubSearch.new("followers", github_token)
    get_followers.followers
  end
end
