# Envm

Environment variable management for large Ruby projects

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'envm', github: "teespring/envm"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install envm

## Usage

Setup

```ruby
# Configure the environment variable manifest file
Envm.manifest_path = File.join(Rails.root, "config", "env.yml")

# Set current enviroment (uses value from env var: RAILS_ENV or RACK_ENV by default)
Envm.environment = 'development'

# Call setup to initialize Envm
Envm.setup
```

Access registered environment varable

```ruby
Envm["DATABASE_URL"]
#=> "mysql2://root@localhost:3306/teespring_dev"
```

Accessing unregistered environment varable will raise an error

```ruby
Envm["DATABASE_URLX"]
#=> fail Envm::EnvVarNotFoundError, "DATABASE_URLX was not found"
```

If you wish to use multiple manifests you can

```ruby
envm1 = Envm.setup do |c|
  c.manifest_path = File.join(Rails.root, "config", "env1.yml")
  c.environment = 'production'
end

envm1['DATABASE_URL']
```

## Manifest

The manifest file is documented in the [MANIFEST.md](MANIFEST.md)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT)
