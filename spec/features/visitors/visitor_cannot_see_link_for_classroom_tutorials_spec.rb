require 'rails_helper'

describe "As a visitor" do
  it "cannot see a link to classroom tutorials" do
    tutorial_1 = create(:tutorial)
    tutorial_2 = create(:tutorial, classroom: true)

    visit "/"

    expect(page).to have_content(tutorial_1.title)
    expect(page).to_not have_content(tutorial_2.title)

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/"

    expect(page).to have_content(tutorial_1.title)
    expect(page).to have_content(tutorial_2.title)
  end
end
