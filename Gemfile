source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby ">= 2.6.0"

gem "bootsnap", require: false
gem "pg"
gem "puma"
gem "rails", "~> 6.0.0"

gem "aws-sdk-s3"
gem "bugsnag"
gem "cloudinary"
gem "kaminari"
gem "scout_apm"
gem "simple_form"
gem "sidekiq"
gem "slim-rails"
gem "turbolinks"
gem "turbolinks_render"
gem "webpacker"

group :development, :test do
  gem "byebug"
  gem "rspec-rails", ">= 4.0.0.beta3"
end

group :development do
  gem "listen"
  gem "pry-rails"
  gem "web-console"
end
