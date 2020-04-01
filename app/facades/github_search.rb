class GithubSearch
  def initialize(path, token)
    retrieve_api = GithubService.new
    @api = retrieve_api.github_info(path, token)
  end
  
  def repos
    @api.map do |repo|
      Repo.new(repo)
    end
  end
  
  def followers
    @api.map do |follower|
      Follow.new(follower)
    end
  end
  
  def following
    @api.map do |following|
      Follow.new(following)
    end
  end
end