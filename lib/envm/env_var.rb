require "envm/config"

module Envm
  class EnvVar
    attr_accessor :name, :description, :default_value, :required

    def initialize(name:, description: nil, default_value: nil, required: [])
      self.name = name
      self.description = description
      self.default_value = default_value
      self.required = []

      if required.respond_to?(:include?)
        self.required = required
      else
        self.required = []
        self.required << DEFAULT_ENV if required
      end
    end

    def value
      if required?(Config.environment)
        system_value or fail(NotSetError, "'#{name}' environment variable was required but set on system.")
      else
        default_value || system_value
      end
    end

    def system_value
      ENV[name]
    end

    private

    def required?(env)
      required.include?(env)
    end
  end
end
