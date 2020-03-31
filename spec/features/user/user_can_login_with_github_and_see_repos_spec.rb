require 'rails_helper'

describe 'A registered user' do
  it 'can sign in with github and see their repos' do
    user = User.create(email: "jennyklich@gmail.com",
                      first_name: "Jenny",
                      last_name: "Klich",
                      password_digest: "Jkgithub@5",
                      role: 0,
                      github_token: "c35dc5837e32a18a135d76dd25c5da81e06785ce")
    user2 = User.create(email: "testtest@gmail.com",
                      first_name: "Test",
                      last_name: "Test",
                      password_digest: "testtest@5",
                      role: 0,
                      github_token: "94e8d8903135162c9d631f111c2386c51a89e746")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    json_response = File.read('spec/fixtures/user_github_info.json')
    stub_request(:get, "https://api.github.com/user/repos?access_token=c35dc5837e32a18a135d76dd25c5da81e06785ce").
        to_return(status: 200, body: json_response)

    visit "/dashboard"

    expect(page).to have_content('Github')
    expect(page).to_not have_content("activerecord-obstacle-course")

    within ".Github" do
      expect(page).to have_link("adopt_dont_shop")
      expect(page).to have_link("backend_module_0_capstone")
      expect(page).to have_link("battleship")
      expect(page).to have_link("best_animals")
      expect(page).to have_link("b2-mid-mod")
    end
  end
  xit "user without token cannot see github section" do
    user = User.create(email: "jennyklich@gmail.com",
                      first_name: "Jenny",
                      last_name: "Klich",
                      password_digest: "Jkgithub@5",
                      role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    expect(page).to_not have_content("Github")
  end
end
