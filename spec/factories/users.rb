FactoryBot.define do
  factory :user do
    name { "tesuser" }
    email { "test@mail.com" }
    password { "password" }
  end
end
