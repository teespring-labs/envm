# Envm

Manage environment variables within your Ruby project

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'envm'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install envm

## Usage

```ruby
require 'envm'

# Configure the environment variable manifest file
# Formatts supported: YML
Envm::Config.mainfest_path = File.join(Rails.root, "config", "env.yml")

# you'll have to manually call setup
Envm.setup

# Access allowed environment varables
Envm["DATABASE_URL"]
#=> "mysql2://root@localhost:3306/teespring_dev"

# Access disallowed environment varables
Envm["DATABASE_URLX"]
#=> fail Envm::EnvVarNotFoundError, "DATABASE_URLX was not found"

# Access environment varables using Ruby's ENV
ENV["DATABASE_URL"]
# => STDERR.puts "Warning: deprecated usage of ENV with value 'DATABASE_URL'"

# Setting environment varables using Ruby's ENV=
ENV["DATABASE_URL"] = "mysql"
# => STDERR.puts "Warning: deprecated usage of ENV= with value 'DATABASE_URL' and 'mysql'"
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
