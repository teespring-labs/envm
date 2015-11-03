require "envm/config"

module Envm
  class EnvVar
    attr_accessor :name, :description, :default_values, :required_environments

    def initialize(name:, description: nil, default_values: nil, set_value_required: [])
      self.name = name
      self.description = description

      if set_value_required.respond_to?(:include?)
        self.required_environments = set_value_required
      else
        self.required_environments = []
        self.required_environments << "all" if set_value_required == true
      end

      if default_values && default_values.is_a?(Hash)
        self.default_values = default_values
      else
        self.default_values = {}
        self.default_values['fallback_value'] = default_values
      end
    end

    def value
      if required_environments.include?(Config.environment) || required_environments.include?("all")
        system_value or fail(NotSetError, "'#{name}' environment variable was required but not set on system.")
      else
        system_value || default_value_for_env
      end
    end

    def default_value_for_env
      default_values[Config.environment] ? default_values[Config.environment] : default_values['fallback_value']
    end

    def system_value
      ENV[name]
    end
  end
end
