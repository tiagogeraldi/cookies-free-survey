require 'rails_helper'

RSpec.describe "Quizer::Answers", type: :request do
  let(:quiz) { create :quiz }
  let!(:question) { create :question, quiz: quiz }
  let(:alternative) { create :alternative, question: question }
  let(:answer) { create :answer, quiz: quiz, alternatives: [alternative] }
  let(:session_hex) { '1234' }

  describe "GET /quizer/answers" do
    it "renders index" do
      get quizer_answers_url(s: quiz.audience_secret)

      expect(response).to have_http_status(200)
      expect(response.body).to include quiz.description
    end
  end

  describe "GET /quizer/answers/new" do
    it "renders new with flash error" do
      get new_quizer_answer_url(s: quiz.audience_secret, question_id: question.id, session_hex: session_hex)

      expect(response).to have_http_status(200)
      expect(response.body).to include question.description
      expect(response.body).to include "This question has no alternatives"
    end
  end

  describe "POST /quizer/answers/upsert" do
    it "creates an answer" do
      post upsert_quizer_answers_url(s: quiz.audience_secret, question_id: question.id, params: {
        quizer_answer: {
          session_hex: session_hex,
          alternative_ids: [alternative.id]
        }
      })
      answer = quiz.answers.last
      expect(answer.alternatives).to include alternative
      expect(answer.session_hex).to eq session_hex
      expect(response).to have_http_status(302)
    end

    it "fails creating an answer" do
      post upsert_quizer_answers_url(s: quiz.audience_secret, question_id: question.id, params: {
        quizer_answer: {
          session_hex: session_hex,
          alternative_ids: []
        }
      })
      expect(response).to have_http_status(422)
    end

    it "updates an answer" do
      post upsert_quizer_answers_url(s: quiz.audience_secret, question_id: question.id, params: {
        quizer_answer: {
          session_hex: answer.session_hex,
          alternative_ids: [alternative.id]
        }
      })
      expect(response).to have_http_status(302)
      expect(answer.reload.alternatives).to include alternative
    end
  end

  describe "GEt /quizer/answers/done" do
    it "renders done" do
      answer
      get done_quizer_answers_url(s: quiz.audience_secret)

      expect(response).to have_http_status(200)
      expect(response.body).to include "Thank you"
      expect(response.body).to include "You answered correctly 0 of 1 questions"
    end
  end
end
