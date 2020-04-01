require 'rails_helper'

describe 'A registered user' do
    before(:each) do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = nil
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
        {"provider" => "github",
          "info"=> {"name"=> "Jennifer Klich"},
          "credentials"=>
          {"token"=>ENV["TEST_KEY"],
            "expires"=>false},
            "extra"=>
            {"raw_info"=>
              {"login"=>"jklich151",
                "html_url"=>"https://github.com/jklich151",
                "name"=>"Jennifer Klich",
                }}})
    end

  it 'can sign in with github' do

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    click_on 'Connect to Github'

    expect(user.github_token).to eq(ENV["TEST_KEY"])
    save_and_open_page
  end
end
