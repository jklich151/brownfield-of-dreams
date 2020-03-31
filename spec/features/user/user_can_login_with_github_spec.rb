# require 'rails_helper'
#
# describe 'A registered user' do
#   it 'can sign in with github' do
    VCR.use_cassette('sign_in_with_github') do
      OmniAuth.config.test_mode = true
      OmniAuth.config.add_mock(:github, {:uid => '12345'})
      OmniAuth.config.mock_auth[:github] = :invalid_credentials
      OmniAuth.config.on_failure = Proc.new { |env|
        OmniAuth::FailureEndpoint.new(env).redirect_to_failure
      }
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]

      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

#       visit '/dashboard'
#
#       click_on 'Connect to Github'
#
#       expect(current_path).to eq("/login/oauth/authorize")
#
#       fill_in "login_field", with: "jennyklich@gmail.com"
#       fill_in "password", with: "Testing@@4455"
#
#       click_on "Sign In"

      # expect sign in to be there
      # expect that someone is signed in.
      # manual test for oauth
      # test token and dev token in app.yml file
      # need token for other user stories
    end
  end
end
