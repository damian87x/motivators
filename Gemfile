source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'jquery-rails'

# group for development environment
group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.9.0'
end


group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end


# group for production environment
group :production do
  # pg library helps access to PostgreSQL database which use heroku
  gem 'pg', '~> 0.12.2'
end