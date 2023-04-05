require 'rails_helper'

RSpec.describe "Quizer::Exports", type: :request do
  let(:quiz) { create :quiz }

  describe "GET /quizer/exports" do
    it "renders index" do
      get quizer_quiz_exports_url(quiz)
      expect(response).to have_http_status(200)
      expect(response.body).to include "Download all questions"
    end
  end

  describe "GET /quizer/exports/ID" do
    it "downloads questions" do
      get quizer_quiz_export_url(quiz, id: 'questions')

      expect(response).to have_http_status(200)
      expect(response.header["Content-Disposition"]).to include 'questions.csv'
    end

    it "downloads answers" do
      get quizer_quiz_export_url(quiz, id: 'answers')

      expect(response).to have_http_status(200)
      expect(response.header["Content-Disposition"]).to include 'answers.csv'
    end
  end
end
