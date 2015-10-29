module Envm
  class Config
    def self.manifest_path
      @_manifest_path.to_s
    end

    def self.manifest_path=(path)
      @_manifest_path = path
    end

    def self.environment
      @_environment || DEFAULT_ENV
    end

    def self.environment=(env)
      @_environment = env
    end
  end
end
