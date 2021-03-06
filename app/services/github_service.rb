class GithubService
  def github_info(path, token)
    get_json("/user/#{path}?access_token=#{token}")
  end

  private

  def get_json(url)
    response = conn.get(url)
    @json = JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com')
  end
end
