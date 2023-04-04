require 'rails_helper'

RSpec.describe "Quizer::Questions", type: :request do
  let(:quiz) { create :quiz }
  let(:question) { create :question, quiz: quiz, position: 0 }
  let(:question2) { create :question, quiz: quiz, position: 1 }

  describe "GET /quizer/questions" do
    it "renders index" do
      get quizer_quiz_questions_url(quiz)

      expect(response).to have_http_status(200)
      expect(response.body).to include 'Questions'
    end
  end

  describe "GET /quizer/questions" do
    it "renders new" do
      get new_quizer_quiz_question_url(quiz)

      expect(response).to have_http_status(200)
      expect(response.body).to include 'New question'
    end
  end

  describe "GET /quizer/questions" do
    it "renders new" do
      get edit_quizer_quiz_question_url(quiz, question)

      expect(response).to have_http_status(200)
      expect(response.body).to include 'Editing question'
    end
  end

  describe "POST /quizer/questions" do
    it "creates a question" do
      post quizer_quiz_questions_url(quiz, params: {
        quizer_question: {
          question_type: 'select_one',
          description: 'any'
        }
      })
      expect(response).to have_http_status(302)
      question = quiz.questions.last
      expect(question.question_type).to eq 'select_one'
      expect(question.description).to eq 'any'
    end
  end

  describe "PATCH /quizer/questions/ID" do
    it "updates a question" do
      patch quizer_quiz_question_url(quiz, question, params: {
        quizer_question: {
          description: 'changing'
        }
      })
      expect(response).to have_http_status(302)
      expect(question.reload.description).to eq 'changing'
    end
  end

  describe "DELETE /quizer/questions/ID" do
    it "deletes a question" do
      delete quizer_quiz_question_url(quiz, question)

      expect(response).to have_http_status(302)
      expect { question.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "PUT /quizer/questions/ID/move_up" do
    it "changes position" do
      question
      put move_up_quizer_quiz_question_url(quiz, question2)

      expect(question.reload.position).to eq 1
      expect(question2.reload.position).to eq 0
    end
  end

  describe "PUT /quizer/questions/ID/move_down" do
    it "changes position" do
      question2
      put move_down_quizer_quiz_question_url(quiz, question)

      expect(question.reload.position).to eq 1
      expect(question2.reload.position).to eq 0
    end
  end

  describe "PUT /quizer/questions/ID/move_top" do
    it "changes position" do
      put move_top_quizer_quiz_question_url(quiz, question2)

      expect(question2.reload.position).to eq 0
    end
  end

  describe "PUT /quizer/questions/ID/move_bottom" do
    it "changes position" do
      question2
      put move_bottom_quizer_quiz_question_url(quiz, question)

      expect(question.reload.position).to eq 1
    end
  end
end
