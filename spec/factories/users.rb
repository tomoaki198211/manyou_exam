FactoryBot.define do
  factory :admin_user, class: User do
    name { "adminuser1" }
    email { "admin@a.com" }
    password { "admin111" }
    password_confirmation { "admin111" }
    admin {true}
  end

  factory :user do
    name { "user99" }
    email { "user1@a.com" }
    password { "user111" }
    password_confirmation { "user111" }
    admin {false}
  end
end
