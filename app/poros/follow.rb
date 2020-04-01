class Follow
  attr_reader :name, :url
  
  def initialize(repo)
    @name = repo[:login]
    @url = repo[:html_url]
  end
end