source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'slim-rails' # slim-railsの導入
gem 'html2slim' # 既存のerbやhtmlファイルをslimに変える

gem 'rubocop' # rubocopの導入
gem 'rubocop-rails'

gem 'sorcery' # ユーザ認証機能を簡単に実装できるライブラリ
gem 'redis-rails'
gem 'annotate'

gem 'jquery-rails'
gem 'popper_js'
gem 'font-awesome-sass'

gem 'rails-i18n', '~> 5.1' # 日本語化

gem 'carrierwave'
gem 'mini_magick'
gem 'faker'

gem 'kaminari' # paginationを実装

gem 'config'
gem 'sidekiq', '~> 5.2.8'
gem 'sinatra'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors' # デフォルトのエラー画面をわかりやすく成形してくれる
  gem 'binding_of_caller' # エラー画面にirbをつけてくれる
  gem 'pry-byebug' # バグを修正するためのツール
  gem 'pry-rails' # Rails用に使われるデバックツール
  gem 'letter_opener_web' # メールをブラウザで確認できる
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'webdrivers'

end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
