require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  before(:example) do
    sign_in user #User.create!(email: "rspec@example.com", password: "password")
  end

  describe "POST create" do
    it "creates a project" do
      fake_action = instance_double(CreatesProject, create: true) # instance_double verifies against methods that are actually part of the instance, if any other called then the test will fail.
      expect(CreatesProject).to receive(:new) # this validates that the controller is calling the correct methods were we want the data to come from.
        .with(name: "Runway", task_string: "start something:2", users: [user])
        .and_return(fake_action) # super important to test the CreatesProject properly since this DOES NOT test its logic.
      post :create, project: { name: "Runway", tasks: "start something:2" }
      expect(response).to redirect_to(projects_path)
      expect(assigns(:action)).not_to be_nil # on the surface may seem like a weaker test but the actual value of the ivar isn't the controller's responsibility - only that is sets one on success
      # expect(assigns(:action).project.name).to eq("Runway")
        # the above assertion is overreaching - beyond the controller's responsibility,
        # the controller's duty is as a conduit for the data passed to it,
        # it's responsibility is how it gathers & moves data - setting a value to satisfy the view & calling some other place for data.
        # The specs for CreatesProject test the logic of building the data,
        # we just need to make sure the controller calls the correct methods(mocks expect to be called!).
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
      sample = Project.create!(name: "Testy McTestertin") # this is set up as such to give the object an id
      # sample = FactoryGirl.build_stubbed(:project)
      #   using Factory Girl's build_stubbed will also get an id without hitting the db
      expect(sample).to receive(:update_attributes).and_return(false)
      allow(Project).to receive(:find).and_return(sample)
      patch :update, id: sample.id, project: {name: "Hal"}
      expect(response).to render_template(:edit)
    end
  end

  describe "GET show" do
    let(:project) { Project.create(name: "Project Runway") }

    it "allows a user who is part of the project to see the project" do
      allow(controller.current_user).to receive(:can_view?).and_return(true)
      # controller.current_user.stub(can_view?: true) # this syntax is being deprecated
      get :show, id: project.id
      expect(response).to render_template(:show)
    end

    it "does not allow a user who is not part of the project to see the project" do
      allow(controller.current_user).to receive(:can_view?).and_return(false)
      get :show, id: project.id
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET index" do
    it "displays all projects correctly" do
      user = User.new
      project = Project.new(:name => "Project Greenlight")
      # controller.expects(:current_user).returns(user)
      expect(controller).to receive(:current_user).and_return(user)
      # user.expects(:visible_projects).returns([project])
      expect(user).to receive(:visible_projects).and_return([project])
      get :index
      assert_equal assigns[:projects].map(&:__getobj__), [project]
    end
  end
end
