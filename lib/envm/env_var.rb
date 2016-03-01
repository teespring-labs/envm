require "envm/config"

module Envm
  class EnvVar
    attr_accessor :name, :default, :secret

    def initialize(name:, default: nil, secret: false)
      self.name = name
      self.default = default
      self.secret = secret
    end

    def secret?
      secret
    end

    def value
      system_value || default
    end

    private

    def system_value
      ENV[name]
    end
  end
end
