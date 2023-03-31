require 'rails_helper'

RSpec.describe Quizer::Quiz, type: :model do
  it { is_expected.to have_many(:questions) }
  it { is_expected.to have_many(:answers) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:quiz_type) }

  describe '.generate_secrets' do
    it 'generates secrets' do
      subject.generate_secrets
      expect(subject.owner_secret).to be_present
      expect(subject.audience_secret).to be_present
    end
  end

  describe '#to_param' do
    it 'returns owner_secret' do
      subject.owner_secret = 'a'
      expect(subject.to_param).to eq 'a'
    end
  end

  describe '#expiration_date' do
    before do
      subject.created_at = Date.new(2023, 3, 31)
    end

    it 'returns 14 days for free records' do
      expect(subject.expiration_date).to eq Date.new(2023, 4, 14)
    end

    it 'returns 180 days for paid records' do
      subject.paid = true
      expect(subject.expiration_date).to eq Date.new(2023, 9, 27)
    end
  end

  describe '#default_description?' do
    context 'quiz' do
      before { subject.quiz_type = 'quiz' }

      it 'returns true when description is the default value' do
        subject.description = described_class::DESCRIPTION_QUIZ_EXAMPLE
        expect(subject.description).to be_present
        expect(subject.default_description?).to eq true
      end

      it 'returns false' do
        expect(subject.default_description?).to eq false
      end
    end

    context 'survey' do
      before { subject.quiz_type = 'survey' }

      it 'returns true when description is the default value' do
        subject.description = described_class::DESCRIPTION_SURVEY_EXAMPLE
        expect(subject.description).to be_present
        expect(subject.default_description?).to eq true
      end

      it 'returns false' do
        expect(subject.default_description?).to eq false
      end
    end
  end

  describe '#correct_answers_count' do
    let(:quiz) { create :quiz }
    let(:session_hex) { "1234" }

    context 'select_one' do
      let(:question) { create(:question, quiz: quiz, question_type: 'select_one') }
      let!(:alternative1) { create(:alternative, question: question, correct: true) }
      let!(:alternative2) { create(:alternative, question: question) }

      it 'counts correct answers for select_one' do
        create :answer, quiz: quiz, question: question, alternatives: [alternative1], session_hex: session_hex

        expect(quiz.correct_answers_count(session_hex)).to eq 1
      end

      it 'counts 0' do
        create :answer, quiz: quiz, question: question, alternatives: [alternative2], session_hex: session_hex

        expect(quiz.correct_answers_count(session_hex)).to eq 0
      end
    end

    context 'select_one_or_more' do
      let(:question) { create(:question, quiz: quiz, question_type: 'select_one_or_more') }
      let!(:alternative1) { create(:alternative, question: question, correct: true) }
      let!(:alternative2) { create(:alternative, question: question) }

      it 'considers correct when at least one correct answer is selected' do
        create :answer, quiz: quiz, question: question, alternatives: [alternative1], session_hex: session_hex

        expect(quiz.correct_answers_count(session_hex)).to eq 1
      end

      it 'considers the answer wrong if an incorrect answer is selected' do
        create :answer, quiz: quiz, question: question, alternatives: [alternative1, alternative2], session_hex: session_hex

        expect(quiz.correct_answers_count(session_hex)).to eq 0
      end
    end
  end

  describe '#expiration_alert_class' do
    before do
      subject.created_at = Date.current
      subject.paid = true
    end

    it 'returns info' do
      expect(subject.expiration_alert_class).to eq 'alert-info'
    end

    it 'returns warning' do
      travel_to 170.days.from_now
      expect(subject.expiration_alert_class).to eq 'alert-warning'
      travel_back
    end

    it 'returns danger' do
      travel_to 177.days.from_now
      expect(subject.expiration_alert_class).to eq 'alert-danger'
      travel_back
    end
  end
end
