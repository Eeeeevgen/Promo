source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

gem 'pg', '0.18.4'

gem 'slim'

gem 'bootstrap-sass',       '3.3.6'

# For passwords hashes
gem 'bcrypt',               '3.1.7'

gem 'authlogic'

gem 'redis'
gem 'redis-namespace'
gem 'leaderboard'

gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'
gem 'omniauth-google-oauth2'

# image uploading and modifying
gem 'carrierwave', '~> 1.1.0'
gem 'carrierwave-base64'
gem 'mini_magick', '~> 4.3'

# for service objects
gem 'active_interaction', '~> 3.5'

# for making trees from comments model
gem 'closure_tree', git: 'git://github.com/ClosureTree/closure_tree.git'

# easy use ENV variable with yml
gem 'figaro'

# serializer for api
gem 'active_model_serializers', '~> 0.10.0'

# admin
gem 'activeadmin', github: 'activeadmin'

# authorization
gem 'pundit'

# state machine
gem 'aasm'

# pagination
gem 'kaminari'
gem 'kaminari-bootstrap'

# for admin users
gem 'devise'

# using amazon s3
gem 'fog-aws'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'rails_12factor', '0.0.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
