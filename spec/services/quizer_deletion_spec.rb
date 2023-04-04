require 'rails_helper'

RSpec.describe QuizerDeletion do
  it 'deletes paid quizzes' do
    create :quiz, paid: true, created_at: (Quizer::Quiz::PAID_PERIOD_DAYS + 1).days.ago
    create :quiz, paid: true, created_at: (Quizer::Quiz::PAID_PERIOD_DAYS + -1).days.ago

    expect {
      described_class.run
    }.to change {
      Quizer::Quiz.count
    }.by(-1)
  end

  it 'deletes free quizzes' do
    create :quiz, paid: false, created_at: (Quizer::Quiz::FREE_PERIOD_DAYS + 1).days.ago
    create :quiz, paid: false, created_at: (Quizer::Quiz::FREE_PERIOD_DAYS + -1).days.ago

    expect {
      described_class.run
    }.to change {
      Quizer::Quiz.count
    }.by(-1)
  end
end
