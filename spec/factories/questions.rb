FactoryBot.define do
  factory :question, class: 'Quizer::Question' do
    quiz
    question_type { 'select_one' }
    description { Faker::Fantasy::Tolkien.poem }
    sequence(:position) { |n| n }
  end
end
