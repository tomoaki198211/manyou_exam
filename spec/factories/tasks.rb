FactoryBot.define do
  factory :task do
    task_name { 'test_task_name' }
    task_detail { 'test_task_detail' }
  end

  factory :second_task, class: Task do
    task_name { '2個目のタスク' }
    task_detail { '2個目のタスク' }
  end
end
