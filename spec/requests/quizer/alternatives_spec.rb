require 'rails_helper'

RSpec.describe "Quizer::Alternatives", type: :request do
  let(:quiz) { create :quiz }
  let(:question) { create :question, quiz: quiz }
  let(:alternative) { create :alternative, question: question }

  describe "GET /quizer/alternatives" do
    it "renders index" do
      get quizer_quiz_question_alternatives_url(quiz, question)

      expect(response).to have_http_status(200)
      expect(response.body).to include 'Alternatives'
    end
  end

  describe "GET /quizer/alternatives/new" do
    it "renders new" do
      get new_quizer_quiz_question_alternative_url(quiz, question)

      expect(response).to have_http_status(200)
      expect(response.body).to include 'New alternative'
    end
  end

  describe "GET /quizer/alternatives/ID/edit" do
    it "renders edit" do
      get edit_quizer_quiz_question_alternative_url(quiz, question, alternative)

      expect(response).to have_http_status(200)
      expect(response.body).to include 'Editing alternative'
    end
  end

  describe "POST /quizer/alternatives" do
    it "creates an alternative" do
      post quizer_quiz_question_alternatives_url(quiz, question, params: {
        quizer_alternative: {
          description: 'any'
        }
      })
      expect(question.alternatives.last.description).to eq 'any'
    end
  end

  describe "PATCH /quizer/alternatives/ID" do
    it "updates an alternative" do
      patch quizer_quiz_question_alternative_url(quiz, question, alternative, params: {
        quizer_alternative: {
          description: 'changing'
        }
      })
      expect(alternative.reload.description).to eq 'changing'
    end
  end
end
