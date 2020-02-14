FactoryBot.define do
  factory :article, class: Article do
    user_id { 1 }
    title { 'ホテルに泊まった' }
    description { 'ホテルに泊まった。ホテルに泊まった。' }
  end
end
