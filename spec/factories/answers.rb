FactoryBot.define do
  factory :answer, class: 'Quizer::Answer' do
    question
    session_hex { Faker::Barcode.ean }

    after :build do |record|
      record.quiz ||= record.question.quiz

      if record.alternatives.blank?
        record.alternatives = [build(:alternative, question: record.question)]
      end
    end
  end
end
