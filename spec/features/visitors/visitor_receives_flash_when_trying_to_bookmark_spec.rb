require 'rails_helper'

describe "As a visitor" do
  it "can see a flash message when trying to bookmark" do
    tutorial_1 = create(:tutorial)
    video = create(:video, tutorial_id: tutorial_1.id)

    visit "/tutorials/#{tutorial_1.id}"

    click_link "Bookmark"

    expect(current_path).to eq("/tutorials/#{tutorial_1.id}")
    expect(page).to have_content("User must login to bookmark videos.")
  end
end
