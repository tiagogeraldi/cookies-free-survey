# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Creating a survey..."

Quizer::Answer.destroy_all
Quizer::Quiz.destroy_all

quiz = Quizer::Quiz.new description: Faker::Quotes::Shakespeare.hamlet_quote
quiz.generate_secrets
quiz.save!

Quizer::Question.question_types.keys.each.with_index do |question_type, index|
  question = quiz.questions.new question_type: question_type, position: index + 1
  question.description = Faker::Quotes::Shakespeare.king_richard_iii
  question.save!

  if !question.descriptive?
    4.times do
      question.alternatives.create!(
        description: Faker::Quotes::Shakespeare.romeo_and_juliet,
        correct: [true, false].sample
      )
    end
  end
end

# 10 people answered the survey
10.times do
  session_hex = SecureRandom.hex(10)

  quiz.questions.each do |question|
    answer = Quizer::Answer.new(
      quiz: quiz,
      question: question,
      session_hex: session_hex
    )
    if !question.descriptive?
      answer.alternatives << question.alternatives.sample
    else
      answer.descriptive = Faker::Quotes::Shakespeare.as_you_like_it
    end

    answer.save!
  end
end

include Rails.application.routes.url_helpers
default_url_options[:host] = 'http://localhost:3000'

puts "Owner link:"
puts url_for([quiz, { only_path: false }])
puts "Audience link:"
puts quizer_answers_url(s: quiz.audience_secret, only_path: false)
