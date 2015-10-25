require 'rails_helper'

RSpec.describe Task do
  it 'can disinguish a completed task' do
    task = Task.new
    expect(task).not_to be_complete
    task.mark_complete
    expect(task).to be_complete
  end
end
