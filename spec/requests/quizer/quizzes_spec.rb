require 'rails_helper'

RSpec.describe "Quizer::Quizzes", type: :request do
  let(:quiz) { create :quiz }

  describe "GET /quizer/quizzes" do
    it "renders index" do
      get quizer_quizzes_url
      expect(response).to have_http_status(200)
      expect(response.body).to include 'Survey Maker'
    end
  end

  describe "GET /quizer/quizzes/help" do
    it "renders help" do
      get help_quizer_quizzes_url
      expect(response).to have_http_status(200)
      expect(response.body).to include 'Quiz or Survey?'
    end
  end

  describe "GET /quizer/quizzes/ID" do
    it "renders show" do
      get quizer_quiz_url(quiz)
      expect(response).to have_http_status(200)
      expect(response.body).to include 'You can start creating your first question'
    end
  end

  describe "GET /quizer/quizzes/new" do
    it "creates quiz type quiz and redirects" do
      expect {
        get new_quizer_quiz_url(quiz_type: 'quiz')
      }.to change {
        Quizer::Quiz.count
      }.by(1)

      expect(Quizer::Quiz.last.description).to eq Quizer::Quiz::DESCRIPTION_QUIZ_EXAMPLE
      expect(response).to have_http_status(302)
    end

    it "creates quiz type SURVEY and redirects" do
      expect {
        get new_quizer_quiz_url(quiz_type: 'survey')
      }.to change {
        Quizer::Quiz.count
      }.by(1)

      expect(Quizer::Quiz.last.description).to eq Quizer::Quiz::DESCRIPTION_SURVEY_EXAMPLE
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /quizer/quizzes/ID/edit" do
    it "renders results" do
      get edit_quizer_quiz_url(quiz)

      expect(response).to have_http_status(200)
      expect(response.body).to include 'The description is a critical component'
    end
  end

  describe "PATCH /quizer/quizzes/ID" do
    it "updates quiz" do
      patch quizer_quiz_url(quiz, params: { quizer_quiz: { description: 'new-desc' }})

      expect(response).to have_http_status(302)
      expect(quiz.reload.description).to eq 'new-desc'
    end

    it "fails when updating" do
      patch quizer_quiz_url(quiz, params: { quizer_quiz: { description: '' }})

      expect(response).to have_http_status(422)
      expect(quiz.reload.description).not_to eq 'new-desc'
    end
  end

  describe "DELETE /quizer/quizzes/ID" do
    it "destroys quiz" do
      delete quizer_quiz_url(quiz)

      expect(response).to have_http_status(302)

      expect{ quiz.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "PATCH /quizer/quizzes/ID/toggle_active" do
    it "updates active" do
      patch toggle_active_quizer_quiz_url(quiz)

      expect(response).to have_http_status(302)
      expect(quiz.reload.active).to eq false

      patch toggle_active_quizer_quiz_url(quiz)
      expect(quiz.reload.active).to eq true
    end
  end

  describe "POST /quizer/quizzes/ID/clone" do
    it 'clones a quiz' do
      question = create(:question, quiz: quiz)
      create :alternative, question: question

      expect {
        post clone_quizer_quiz_url(quiz)
      }.to change {
        Quizer::Quiz.count
      }.by(1)

      new_quiz = Quizer::Quiz.last
      expect(new_quiz.description).to eq quiz.description
      expect(new_quiz.questions).to be_present
      expect(new_quiz.questions.first.alternatives).to be_present
    end
  end
end
