require 'rails_helper'

describe 'A registered user' do
  before :each do
    json_response = File.read('spec/fixtures/user_github_info.json')
    stub_request(:get, "https://api.github.com/user/repos?access_token=#{ENV["Github_token_jenny"]}").
        to_return(status: 200, body: json_response)

    json_response = File.read('spec/fixtures/user_following.json')
    stub_request(:get, "https://api.github.com/user/following?access_token=#{ENV["Github_token_jenny"]}").
        to_return(status: 200, body: json_response)
    
    json_response = File.read('spec/fixtures/user_followers.json')
    stub_request(:get, "https://api.github.com/user/followers?access_token=#{ENV["Github_token_jenny"]}").
        to_return(status: 200, body: json_response)
  end
  
  it "under github, can see a list of who they follow" do
    user = User.create!(email: "jennyklich@gmail.com",
                      first_name: "Jenny",
                      last_name: "Klich",
                      password: "JennyGithub",
                      role: 0,
                      github_token: ENV["Github_token_jenny"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    expect(page).to have_content("Github")
    expect(page).to have_content("Following")

    within ".Following" do
      expect(page).to have_link("caachz", href: "https://github.com/caachz")
      expect(page).to have_link("jrsewell400", href: "https://github.com/jrsewell400")
      expect(page).to have_link("iEv0lv3", href: "https://github.com/iEv0lv3")
      expect(page).to have_link("rcallen89", href: "https://github.com/rcallen89")
    end
  end
end
