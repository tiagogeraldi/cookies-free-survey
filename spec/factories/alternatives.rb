FactoryBot.define do
  factory :alternative, class: 'Quizer::Alternative' do
    question
    description { Faker::Fantasy::Tolkien.character }
  end
end
