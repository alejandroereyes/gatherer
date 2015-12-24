FactoryGirl.define do
  factory :project do
    name "Project Runway" # all attribute assignments in a factory can be overwritten during the call to build them
    due_date { Date.today - rand(50) }
  end
end

FactoryGirl.define do
  factory :big_project, class: Project do
    name "Big Project"
  end
end
