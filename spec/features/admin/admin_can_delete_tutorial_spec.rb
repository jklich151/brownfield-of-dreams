require 'rails_helper'

feature "An admin can delete a tutorial" do
  scenario "and it should no longer exist" do
    admin = create(:admin)
    create_list(:tutorial, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect(page).to have_css('.admin-tutorial-card', count: 1)
  end

  scenario "videos are deleted when tutorial is deleted" do
    admin = create(:admin)
    tutorial_1 = create(:tutorial)
    video_1 = create(:video, tutorial_id: tutorial_1.id)
    video_2 = create(:video, tutorial_id: tutorial_1.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect(Video.where(id: video_1.id)).to eq([])
  end
end
