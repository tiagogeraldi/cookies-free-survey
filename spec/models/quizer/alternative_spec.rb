require 'rails_helper'

RSpec.describe Quizer::Alternative, type: :model do
  it { is_expected.to belong_to(:question) }
  it { is_expected.to have_many(:answer_alternatives) }
  it { is_expected.to have_many(:answers) }

  it { is_expected.to validate_presence_of(:description) }

  describe '#percentage' do
    it 'returns 0 when thre is no answer' do
      expect(subject.percentage).to eq 0
    end

    it 'calculates percentage' do
      question = create(:question)
      create_list :answer, 4, question: question
      alternative = create(:alternative, question: question)
      alternative.answers << question.answers.first

      expect(alternative.percentage).to eq 25.0
    end
  end

  describe '#answers_count' do
    it 'returns count' do
      alternative = create(:alternative)
      create_list :answer, 2, alternatives: [alternative]

      expect(alternative.answers_count).to eq 2
    end
  end
end
