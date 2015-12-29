require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user)    { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }

  it "cannot view a project it is not a part of" do
    expect(user.can_view?(project)).to be_falsy
  end

  it "can view a project it is a part of" do
    user.roles.create!(project: project)
    expect(user.can_view?(project)).to be_truthy
    end

  describe "public roles" do

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
