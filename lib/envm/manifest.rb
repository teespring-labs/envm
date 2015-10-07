require "envm/error"
require "envm/manifest_loader"
require "envm/env_var"

module Envm
  class Manifest
    def initialize
      @env_vars = ManifestLoader.load
    end

    def fetch(name)
      env_var = @env_vars.fetch(name)
      env_var.value
    rescue KeyError
      fail NotFoundError, "'#{name}' environment variable was not found."
    end
  end
end
