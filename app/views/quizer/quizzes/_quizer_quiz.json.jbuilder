json.extract! quizer_quiz, :id, :description, :owner_secret, :audience_secret{20}, :public_results, :created_at, :updated_at
json.url quizer_quiz_url(quizer_quiz, format: :json)
