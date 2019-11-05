source 'https://rubygems.org'

gem 'rails', '5.1.7'

gem 'dotenv-rails'
gem 'rack-cors', :require => 'rack/cors'
# Used for 'respond_to' feature
gem 'responders', '~> 2.0'
gem 'rotp'
gem 'secure_headers'
gem 'standard-file', '0.3.5', require: 'standard_file'
gem 'tzinfo-data'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Deployment tools
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger', '>= 0.2.0'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-sidekiq'
  gem 'listen'
  gem 'puma'
  gem 'rspec-rails'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'sqlite3'
end

group :production, :staging, :docker do
  gem 'mysql2', '>= 0.3.13', '< 0.5'
end

