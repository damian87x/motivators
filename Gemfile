source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'jquery-rails'
# this is the most popular gem for users authentication
gem 'devise'
gem 'simple_form', '2.1.0'
gem "paperclip", "~> 3.0"
# group for development environment
group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.9.0'

  # Web server library for test & development
  gem 'webrick'
  # Show schema from database and put in models
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
end


group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass', '~> 2.3.1.0'
end


# group for production environment
group :production do
  # pg library helps access to PostgreSQL database which use heroku
  gem 'pg', '~> 0.12.2'
end