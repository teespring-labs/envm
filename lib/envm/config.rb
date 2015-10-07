module Envm
  class Config
    def self.mainfest_path
      @_mainfest_path.to_s
    end

    def self.mainfest_path=(path)
      @_mainfest_path = path
    end

    def self.environment
      @_environment || DEFAULT_ENV
    end

    def self.environment=(env)
      @_environment = env
    end
  end
end
