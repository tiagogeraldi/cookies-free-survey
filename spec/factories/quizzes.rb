FactoryBot.define do
  factory :quiz, class: 'Quizer::Quiz' do
    quiz_type { 'quiz' }
    paid { false }
    description { Faker::Quote.famous_last_words }
    owner_secret { Faker::Barcode.ean }
    audience_secret { Faker::Barcode.ean }
  end
end
