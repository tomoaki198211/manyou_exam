FactoryBot.define do
  factory :task do
    task_name { 'test_task_name' }
    task_detail { 'test_task_detail' }
    expiry_date {'2022/12/21'}
    status {'着手中'}
  end

  factory :second_task, class: Task do
    task_name { '2個目のタスク' }
    task_detail { '2個目のタスク' }
    expiry_date {'2020/12/01'}
    status {'完了'}
  end

  factory :third_task, class: Task do
    task_name { '3個目のダンス' }
    task_detail { '3個目のタスク' }
    expiry_date {'2018/12/01'}
    status {'未着手'}
  end

  factory :forth_task, class: Task do
    task_name { '4個目のラスク' }
    task_detail { '4個目のタスク' }
    expiry_date {'2022/12/07'}
    status {'未着手'}
  end
end
