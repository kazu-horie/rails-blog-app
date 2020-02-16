FactoryBot.define do
  factory :article, class: Article do
    user_id { 1 }
    title { 'ホテルに泊まった' }
    description { 'とても疲れが取れた。とても疲れが取れた。' }
  end
end
