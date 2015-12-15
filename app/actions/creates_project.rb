class CreatesProject
  attr_accessor :name, :task_string, :project

  def initialize(name: "", task_string: "")
    @name = name
    @task_string = task_string
  end

  def build
    self.project = Project.new(name: name)
    project.tasks << convert_string_to_task
    project
  end

  def convert_string_to_task
    size = 0 if task_string == ""
    Task.new(title: task_string, size: size)
  end
end
