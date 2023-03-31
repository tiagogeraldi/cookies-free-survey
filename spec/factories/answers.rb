FactoryBot.define do
  factory :answer, class: 'Quizer::Answer' do
    question
    session_hex { Faker::Barcode.ean }

    after :build do |record|
      record.quiz = record.question.quiz
    end
  end
end
