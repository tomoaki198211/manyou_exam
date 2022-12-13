require 'date'
labels = [
  {id: 1, label_name: "java"},
  {id: 2, label_name: "javascript"},
  {id: 3, label_name: "python"},
  {id: 4, label_name: "php"},
  {id: 5, label_name: "go"},
  {id: 6, label_name: "c++"},
  {id: 7, label_name: "c"},
  {id: 8, label_name: "cobol"},
  {id: 9, label_name: "swift"},
  {id: 10, label_name: "ruby"},
]

labels.each do |label|
  Label.find_or_create_by(label)
end

User.create!(
    name: "adminuser",
    email: "admin@1.com",
    password: "admin8888",
    admin: true
)

10.times{|n|
    User.create!(
    name: "users"+n.to_s,
    email: "users@"+n.to_s+".com",
    password: "user"+(n.to_s)*4,
    admin: false
    )
}

start_day = Date.new(2018,5,1)
last_day = Date.new(2022,12,31)
users = User.all

users = users.map{|user|user.id}

100.times{|n|
  Task.create!(
    task_name: 'タスク名だよ'+n.to_s,
    task_detail: 'タスク内容'+n.to_s,
    expiry_date: rand(start_day..last_day),
    status: rand(1..3),
    priority: rand(1..3),
    user_id: users.sample
  )
}

tasks = Task.all
tasks = tasks.map{|task| task.id}

100.times{|n|
  Tidy.create(
    label_id: rand(1..10),
    task_id: tasks.sample
  )
}
