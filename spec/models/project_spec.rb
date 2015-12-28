require 'rails_helper'

RSpec.describe Project do

  describe "initialization" do
    let(:project) { Project.new }
    let(:task)    { Task.new }

    it 'considers a project with no tasks to be done' do
      expect(project).to be_done # using the implicit matcher 'done' from be_done will be set as predicate method on project ie. project.done?
    end

    it 'knows that a project with an imcomplete task is not done' do
      project.tasks << task
      expect(project).to_not be_done #using the implicit matcher do use done as predicate method for project ie. project.done? will be called
    end

    it 'marks a project done if its task are done' do
      project.tasks << task
      task.mark_completed
      expect(project).to be_done
    end

    it "properly estimates a blank project" do
      expect(project.completed_velocity).to eq(0)
      expect(project.current_rate).to eq(0)
      expect(project.projected_days_remaining.nan?).to be_truthy
      expect(project).not_to be_on_schedule
    end
  end

  describe 'estimates' do
    let(:project)        { Project.new }
    let(:newly_done)     { Task.new(size: 3, completed_at: 1.day.ago) }
    let(:old_done)       { Task.new(size: 2, completed_at: 6.months.ago) }
    let(:small_not_done) { Task.new(size: 1) }
    let(:large_not_done) { Task.new(size: 4) }

    before(:example) do
      project.tasks = [newly_done, old_done, small_not_done, large_not_done]
    end

    it "knows its velocity" do
      expect(project.completed_velocity).to eq(3)
    end

    it "knows its rate" do
      expect(project.current_rate).to eq(1.0 / 7)
    end

    it "knows its projected time remaining" do
      expect(project.projected_days_remaining).to eq(35)
    end

    it "knows if it is on schedule" do
      project.due_date = 1.week.from_now
      expect(project).not_to be_on_schedule
      project.due_date = 6.months.from_now
      expect(project).to be_on_schedule
    end

    it 'can calculate total size' do
      expect(project).to be_of_size(10)
      expect(project).to be_of_size(5).for_incomplete_tasks_only
    end

    it 'can calculate remaining size' do
      expect(project.remaining_size).to eq(5)
    end
  end

  describe "dealing with doubles - stubs & mocks" do
    context "stubbing" do
      it "stubs and object by letting it receive a message and returning nill" do
        project = Project.new(name: "Project Greenlight")
        allow(project).to receive(:name) # in the stub implementation the message is never sent to the actual object, the stub intercepts
        expect(project.name).to be_nil
      end

      it "stubs by allowing a message and returning the speficied resopnse" do
        project = Project.new(name: "Project Greenlight")
        allow(project).to receive(:name).and_return("Fred") # the stub here returns "Fred" when in intercepts the :name
        expect(project.name).to eq("Fred")
      end

      it "stubs the class" do
        allow(Project).to receive(:find).and_return(
          Project.new(name: "Project Greenlight")) # it's also possible to stud a class
        project = Project.find(1) # by stubbing find, we're not hitting the db. Should avoid stub on find, it would be better to stub a specific created model method that has meaningful and specific behavior.
        # allow_any_instance_of(Project).to receive(:save).and_return(false) # this would allow any instance of a class to stub a certian message.
        expect(project.name).to eq("Project Greenlight")
      end
    end

    context "mocking" do
      it "mocks an object" do
        mock_project = Project.new(name: "Project Greenlight")
        expect(mock_project).to receive(:name).and_return("Fred") # a mock sets up an expectation that a specific message will be sent to the mock object, otherwise the test will fail.
        expect(mock_project.name).to eq("Fred") # Note: a stub is equal to a mock expectation defined with at_least(0).times
      end
    end
  end

  describe "task order" do
    let(:project) { project = Project.create(name: "Project") }

    it "gives me the order of the first task in an empty project" do
      expect(project.next_task_order).to eq(1)
    end

    it "gives me the order of the next task in a project" do
      project.tasks.create(project_order: 3)
      expect(project.next_task_order).to eq(4)
    end
  end
end
