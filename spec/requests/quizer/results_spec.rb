require 'rails_helper'

RSpec.describe "Quizer::Results", type: :request do
  let(:quiz) { create :quiz }
  let(:question) { create :question, quiz: quiz }
  let(:alternative) { create :alternative, question: question }
  let!(:answer) { create :answer, quiz: quiz, alternatives: [alternative] }

  describe "GET /quizer/results" do
    it "renders index" do
      get quizer_quiz_results_url(quiz)

      expect(response).to have_http_status(200)
      expect(response.body).to include "1 person have answered your quiz across 1 question"
    end
  end

  describe "GET /quizer/results/ID" do
    it "renders index" do
      get quizer_quiz_result_url(quiz, question)

      expect(response).to have_http_status(200)
      expect(response.body).to include question.description
      expect(response.body).to include 'Percentage'
      expect(response.body).to include alternative.description
    end
  end

  describe "GET /quizer/results/logs" do
    it "render logs" do
      get logs_quizer_quiz_results_url(quiz)

      expect(response).to have_http_status(200)
      expect(response.body).to include "All answers"
    end
  end

  describe "DELETE /quizer/results/delete_all" do
    it "deletes all answers" do
      delete delete_all_quizer_quiz_results_url(quiz)

      expect(response).to have_http_status(302)
      expect { answer.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
