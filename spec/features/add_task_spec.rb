require 'rails_helper'

describe "adding a new task" do
  fixtures :all
  include Warden::Test::Helpers

  before(:example) do
    login_as users(:user)
  end

  it "can add and reorder a task" do
    visit project_path(projects(:bluebook))
    fill_in "Task", with: "Find UFOs"
    select "2", from: "Size"
    click_on "Add Task"
    expect(current_path).to eq(project_path(projects(:bluebook)))
    within("#task_3") do
      expect(page).to have_selector(".name", text: "Find UFOs")
      expect(page).to have_selector(".size", text: "2")
      expect(page).to_not have_selector("a", text: "Down")
      click_on("Up")
    end
    expect(current_path).to eq(project_path(projects(:bluebook)))
    within("#task_2") do
      expect(page).to have_selector(".name", text: "Find UFOs")
    end
  end
end