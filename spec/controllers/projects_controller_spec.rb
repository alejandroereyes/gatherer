require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  describe "POST create" do
    it "creates a project" do
      post :create, project: { name: "Runway", tasks: "Start something:2" }
      expect(response).to redirect_to(projects_path)
      expect(assigns(:action).project.name).to eq("Runway")
    end

    it "goes back to the form on failure" do
      post :create, project: { name: "", tasks: "" }
      expect(response).to render_template(:new)
      expect(assigns(:project)).to be_present
    end

    it "fails create gracefully" do # example of a create failure using doubles
      action_stub = double(create: false, project: Project.new) # the fully stubbed object, adding a method "create" that can return a false value
      expect(CreatesProject).to receive(:new).and_return(action_stub) # setting up a mock expectation
      post :create, :project => {name: "Project Build a Birdhouse"} # sending a request to the controller
      expect(response).to render_template(:new) # when the controller gets an unsuccessful value from .create, it redirects the new template
      # what we are testing here how the CONTROLLER responds to an unsuccessful save event, not what the CreatesProject object does,
      #   nor that it wasn't saved to the db(especially since we're not even hitting the db by using doubles, this speeds up the test and
      #   isolates the test to CONTROLLER'S behavior).
    end

    it "fails update gracefully" do
      sample = Project.create!(name: "Testy McTestertin") # this is set up as such to give the object an id, try using Factory Girl's build_stubbed after you get the test to pass
      expect(sample).to receive(:update_attributes).and_return(false)
      allow(Project).to receive(:find).and_return(sample)
      patch :update, id: sample.id, project: {name: "Hal"}
      expect(response).to render_template(:edit)
    end
  end
end
