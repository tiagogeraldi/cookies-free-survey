# README

This is a web app to create surveys or quizzes.

It is based on the idea that no session or cookies are necessary being a GDPR / Privacy / Free of tracking product.

## How does it work?

When you generate a quiz or survey, it creates a unique owner link. Saving it, you can always go back to manage and see your survey results.

In the same way, it generates a unique link you can send to your audience.

## Setup

This is a Rails 7 with Hotwire project.

`asdf install ruby 3.2.1 # or adapt it to your favorite ruby installer`

`gem install bundler`

`bundle install`

`bundle exec rake db:create db:migrate`

`bundle exec rails s`

Go to:

`https://localhost:3000`

Or have a pre-defined survey to use as an example:

`bundle exec rake db:seed`
