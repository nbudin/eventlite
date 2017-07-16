source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.0.rc1'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'coffee-script'
gem 'webpacker'
gem 'webpacker-react', "~> 0.2.0"
gem 'erubis'

gem 'devise'
gem 'cancancan'
gem 'responders'

gem 'acts_as_list'

gem 'bootstrap_form', github: 'bootstrap-ruby/rails-bootstrap-forms', branch: 'bootstrap-v4'
gem 'bootstrap', '~> 4.0.0.alpha6'
gem "font-awesome-rails"
#gem 'cadmus', '~> 0.6.0'
gem 'cadmus', path: '/Users/nbudin/src/cadmus'
gem 'cadmus_files', path: '/Users/nbudin/src/cadmus_files'
gem 'cadmus_navbar', path: '/Users/nbudin/src/cadmus_navbar'
gem 'haml'

gem 'carrierwave'
gem 'money-rails'
gem 'stripe'
gem 'with_advisory_lock'

gem 'rails-assets-tether', source: 'https://rails-assets.org'

gem 'rollbar'
gem 'oj'

gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'dotenv-rails'
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-rbenv'
  gem 'capistrano-maintenance', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'pry-rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
