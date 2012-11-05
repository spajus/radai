source 'https://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'activeadmin'
gem 'meta_search'
gem 'devise'
gem 'geocoder'
gem 'gmaps4rails'
gem 'redcarpet'
gem 'kaminari'
gem 'sitemap_generator'
gem 'dalli'
gem 'newrelic_rpm'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'compass-rails'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'twitter-bootstrap-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'mysql2'
  gem 'thin'
  gem 'execjs'
  gem 'therubyracer'
  gem 'exception_notification'
end

group :development do
  gem 'guard-rspec'
  gem 'guard-ctags-bundler'
  gem 'rb-readline'
  gem 'rb-fsevent'
end

group :test, :development do
  gem 'rails-footnotes'
  gem 'awesome_print'
  gem 'pry-nav'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'rspec-rails'
end

gem 'jquery-rails', '~> 2.1'

gem 'capistrano'
gem 'rvm-capistrano'

