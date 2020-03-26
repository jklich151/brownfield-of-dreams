require 'rails_helper'

describe 'A registered user' do
  it 'can sign in with github' do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:github, {:uid => '12345'})
    OmniAuth.config.mock_auth[:github] = :invalid_credentials
    OmniAuth.config.on_failure = Proc.new { |env|
      OmniAuth::FailureEndpoint.new(env).redirect_to_failure
    }
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    click_on 'Connect to Github'

    expect(current_path).to eq("https://github.com/login/oauth/authorize")
  end
end
