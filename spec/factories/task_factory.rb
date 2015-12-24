FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    # project - Although it's possible to assign associations, it also obscures them in the test and it make encourage coupling
    # association :doer, factory: :user, name: "Task Doer", strategy: :build
    #   this is another way to build an association if the association name doesn't match the factory name
    #   adding the strategy can help speed up tests but make sure you don't need it in the db or else your test will fail.
    #   you can get around this by using :build_stubbed
    # user_email { generate(:email) } # generate is needed here becuase the attribute and the sequence have different names

      trait :small do # traits define a set of attributes
        size 1
      end

      trait :large do
        size 5
      end

      trait :soon do
        due_date { 1.day.from_now }
      end

      trait :later do
        due_date { 1.month.from_now }
      end

      factory :trivial do # factories can be defined with traits
        small
        later
      end

      factory :panic, traits: [:small, :later] # another syntax option to define a factory such as the one above
    end

    # factory :hard_task do # inherited factories share attribute the parent's attributes but can be overwritten
    # end

  factory :big_task, parent: :task do
    size 5
  end

  factory :small_task, parent: :task do
    size 1
  end
end
