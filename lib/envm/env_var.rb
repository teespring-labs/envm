require "envm/config"

module Envm
  class EnvVar
    attr_accessor :name, :description, :default_value, :required_environments, :env

    def initialize(name:, description: nil, default_value: nil, required: [], env: ENV)
      self.name = name
      self.description = description
      self.default_value = default_value
      self.env = env

      if required.respond_to?(:include?)
        self.required_environments = required
      else
        self.required_environments = []
        self.required_environments << DEFAULT_ENV if required
      end
    end

    def required_and_missing?
      required_environments.include?(Config.environment) && !system_value
    end

    def value
      if required_and_missing?
        fail(NotSetError, "'#{name}' environment variable was required but not set on system.")
      end

      system_value || default_value
    end

    def system_value
      env[name]
    end
  end
end
