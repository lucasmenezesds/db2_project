source 'https://rubygems.org'
git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Databases on Rails. Build a persistent domain model by mapping database tables to Ruby classes.
gem 'activerecord', '~> 5.2'

# A beautiful and powerful interactive command line prompt https://piotrmurach.github.io/tty/
gem 'tty-prompt', '~> 0.16.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Behaviour Driven Development for Ruby
  gem 'rspec', '~> 3.7'
end

group :development do
  # Guard::RSpec automatically run your specs (much like autotest)
  gem 'guard-rspec', require: false

  # Code coverage for Ruby 1.9+ with a powerful configuration library and automatic merging of coverage across test suites
  gem 'simplecov', require: false

  # A Ruby code quality reporter
  gem 'rubycritic', require: false
end
