require 'rails_helper'

RSpec.describe User, type: :model do

  it "cannot view a project it is not a part of" do
    user = User.new
    project = Project.new
    expect(user.can_view?(project)).to be_falsy
  end
end
