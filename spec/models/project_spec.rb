require 'rails_helper'

RSpec.describe Project do

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
    task.mark_complete
    expect(project).to be_done
  end
end
