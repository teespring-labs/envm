require 'yaml'
require 'envm/config'
require 'envm/env_var'
require 'envm/manifest'

module Envm
  class Loader
    attr_reader :config

    def initialize(config)
      @config = config
    end

    # sets up and returns a Manifest object for a given path to file
    def load
      file_contents = File.read(config.manifest_path)
      contents = YAML.load(file_contents)

      manifest = Manifest.new

      contents.each do |key, env_attrs|
        if env_attrs['secret'] && config.secret_environment?
          default_value = nil
        else
          default_value = env_attrs['default']
        end

        current_var = EnvVar.new(name: key, default: default_value, secret: !!env_attrs['secret'])
        manifest.register(current_var)
      end

      manifest
    end
  end
end
