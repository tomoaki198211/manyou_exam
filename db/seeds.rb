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
