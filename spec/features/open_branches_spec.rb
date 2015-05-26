require 'rails_helper'

feature "the root page" do
  it "should list every NYPL branch" do
    visit root_url
    expect(page).to have_content "Aguilar Library"
    expect(page).to have_content "Yorkville Library"
  end

  it "should link to the branch's status page" do
    visit root_url
    expect(page).to have_link "Aguilar Library"
  end
end

feature "the branch page" do
  before(:each) do
    visit location_url("aguilar")
  end

  it "should display information about the library's status" do
    expect(page).to have_content "Aguilar Library is"
  end

  it "should link back to the branch index" do
    expect(page).to have_link "Back to index"
  end

  it "should have a form for offsetting by a number of days" do
    expect(page).to have_field "offset"
  end

  feature "checks status by days offset" do
    it "should display information about the branch's status a few days from now" do
      fill_in "offset", with: "2"
      click_button "Check by offset!"
      expect(page).to have_content "On #{(Time.now + 2.days).strftime("%m/%d/%Y")} Aguilar Library will be "
    end
  end

  feature "checks status by timestamp" do
    it "should disply information about the branch's status at a specific time on a specific date" do
      fill_in "date", with: "2015-05-31"
      fill_in "time", with: "12:00 PM"
      click_button "Check by timestamp!"
      expect(page).to have_content "On 05/31/2015 Aguilar Library will be closed at 12:00PM."
      expect(page).to have_content "On 05/31/2015 Aguilar Library will be closed."
    end
  end

end
