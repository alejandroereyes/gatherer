require 'rails_helper'

RSpec.describe User, type: :model do

  it "cannot view a project it is not a part of" do
    user = User.new
    project = Project.new
    expect(user.can_view?(project)).to be_falsy
  end

  describe "public roles" do
    let(:user) { User.new }
    let(:project) { Project.new }

    it "allows an admin to view a project" do
      user.admin = true
      expect(user.can_view?(project)).to be_truthy
    end

    it "allows a public project to be seen by anyone" do
      project.public = true
      expect(user.can_view?(project)).to be_truthy
    end
  end
end
