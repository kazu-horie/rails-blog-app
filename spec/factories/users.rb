FactoryBot.define do
  factory :user, class: User do
    email { 'test@example.com' }
    password { 'password' }
  end
end
