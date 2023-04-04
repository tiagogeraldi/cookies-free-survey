require 'rails_helper'

RSpec.describe Quizer::Question, type: :model do
  it { is_expected.to belong_to(:quiz) }
  it { is_expected.to have_many(:alternatives) }
  it { is_expected.to have_many(:answers) }

  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:position) }

  describe '.question_types_for_select' do
    it 'returns array of types for quiz type' do
      quiz = build(:quiz, quiz_type: 'quiz')
      list = described_class.question_types_for_select(quiz)

      expect(list.size).to eq 2
      expect(list).to include ['Select only one alternative', 'select_one']
      expect(list).to include ['Select one or more alternatives', 'select_one_or_more']
    end

    it 'returns array of types for quiz type' do
      quiz = build(:quiz, quiz_type: 'survey')
      list = described_class.question_types_for_select(quiz)

      expect(list.size).to eq 3
      expect(list).to include ['Select only one alternative', 'select_one']
      expect(list).to include ['Select one or more alternatives', 'select_one_or_more']
      expect(list).to include ['Open ended, no alternatives', 'open_ended']
    end
  end

  context 'navigation' do
    let(:quiz) { create :quiz }
    let!(:question1) { create :question, quiz: quiz }
    let!(:question2) { create :question, quiz: quiz }
    let!(:question3) { create :question, quiz: quiz }

    describe '#prev_question' do
      it 'returns prev question' do
        expect(question3.prev_question).to eq question2
        expect(question2.prev_question).to eq question1
      end
    end

    describe '#next_question' do
      it 'returns next question' do
        expect(question1.next_question).to eq question2
        expect(question2.next_question).to eq question3
      end
    end

    describe '#switch_position!' do
      it 'changes position' do
        pos1 = question1.position
        pos2 = question2.position
        question1.switch_position!(question2)

        expect(question1.reload.position).to eq pos2
        expect(question2.reload.position).to eq pos1
      end
    end

    describe '#move_top!' do
      it 'goes to the top' do
        question3.move_top!
        expect(question3.reload.position).to eq 0
      end
    end

    describe '#move_bottom!' do
      it 'goes to the bottom' do
        question1.move_bottom!
        expect(question1.reload.position).to eq 2
      end
    end
  end

  describe '#answers_count' do
    it 'returns count' do
      question = create(:question)
      create_list :answer, 2, question: question

      expect(question.answers_count).to eq 2
    end
  end
end
