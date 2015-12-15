require 'rails_helper'

describe CreatesProject do
  it "creates a project given a name" do
    creator = CreatesProject.new(name: "Project Runway")
    creator.build
    expect(creator.project.name).to eq("Project Runway")
  end

  describe "task string parsing" do
    it "handles an empty string" do
      creator = CreatesProject.new(name: "Test", task_string: "")
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(0)
    end

    it "handles a single string" do
      creator = CreatesProject.new(name: "Test", task_string: "Start things")
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.map(&:title)).to eq(["Start things"])
      expect(tasks.map(&:size)).to eq([1])
    end
  end
end