# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)1

User.create!(name: "adminuser",
            email: "admin@1.com"
            password: "admin8888"
            admin: true
)

User.create!(name: "user",
  email: "user@1.com"
  password: "user8888"
  admin: false
)

