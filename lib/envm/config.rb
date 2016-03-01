module Envm
  class Config
    attr_accessor :environment, :manifest_path, :secret_environments

    def environment
      @environment || ENV['RAILS_ENV'] || ENV['RACK_ENV']
    end

    def secret_environments
      @secret_environments ||= ['production', 'staging']
    end

    def secret_environment?
      secret_environments.include?(environment)
    end
  end
end
