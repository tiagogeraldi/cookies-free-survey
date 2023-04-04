require 'rails_helper'

RSpec.describe QuizerExporter do
  let(:quiz) { create :quiz }
  let(:question) { create :question, quiz: quiz }
  let(:alternative) { create :alternative, question: question }
  let(:answer) { create :answer, alternatives: [alternative], quiz: quiz }

  subject { described_class.new(quiz) }

  describe '.questions_csv' do
    it 'generates CSV' do
      alternative
      csv = subject.questions_csv

      expect(csv).to include 'QuestionID'
      expect(csv).to include 'Alternative'
      expect(csv).to include question.description
      expect(csv).to include alternative.id
    end
  end

  describe '.answers_csv' do
    it 'generates CSV' do
      answer
      csv = subject.answers_csv

      expect(csv).to include 'QuizId'
      expect(csv).to include 'CreatedAt'
      expect(csv).to include alternative.created_at.to_s
      expect(csv).to include answer.session_hex
    end
  end
end
