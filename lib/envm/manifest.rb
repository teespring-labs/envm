require "envm/error"

module Envm
  class Manifest
    def initialize
      # hash for O(1) lookups
      @env_vars = {}
    end

    def register(env_var)
      @env_vars[env_var.name] = env_var
    end

    # returns value for given env var name (e.g. 'DATABASE_URL')
    def fetch(name)
      env_var = @env_vars.fetch(name)
      env_var.value
    rescue KeyError
      fail NotFoundError, "'#{name}' environment variable was not registered with the manifest"
    end
    alias [] fetch

    # returns all env vars without a default or system values
    def secrets
      @env_vars.each_with_object([]) do |(_, env_var), secret_vars|
        secret_vars << env_var if env_var.secret?
      end
    end

    def missing
      @env_vars.each_with_object([]) do |(_, env_var), missing_vars|
        missing_vars << env_var if env_var.value.nil?
      end
    end
  end
end
