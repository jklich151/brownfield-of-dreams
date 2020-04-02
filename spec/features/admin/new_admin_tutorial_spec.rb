require 'rails_helper'

describe "As an admin" do
  it "can add a new tutorial" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    fill_in "Title", with: "Parks and Rec: Season 2 Bloopers"
    fill_in "Description", with: "It's The Worrrrssst"
    fill_in "Thumbnail", with: "https://i.ytimg.com/an_webp/cIcNqn89BoU/mqdefault_6s_480x270.webp?du=3000&sqp=CKubl_QF&rs=AOn4CLBCTdhpJm-us-2shqdG6loixg8mrQ"

    click_on "Save"

    new_tutorial = Tutorial.last

    expect(current_path).to eq("/tutorials/#{new_tutorial.id}")

    expect(page).to have_content("Successfully created tutorial.")
  end
end
