require "envm/config"
require "envm/error"
require "envm/manifest_validator"
require "envm/parser"

module Envm
  class ManifestLoader
    def self.load
      new.load
    end

    def load
      if Config.mainfest_path.empty?
        fail ManifestNotSetError, "Manifest file not set. You can do this Envm::Config.manifest_path = 'path/to/env.yml'"
      end

      unless File.exist?(Config.mainfest_path)
        fail ManifestNotSetError, "Manifest file not found at #{Config.mainfest_path}"
      end

      unless manifest_validator.valid?
        fail MalformedManifestError, "#{Config.mainfest_path} does not contain a valid manifest."
      end

      vars = {}
      manifest_contents.each_key do |key|
        env_attrs = manifest_contents[key]

        current_var = EnvVar.new(
            name: key,
            description: env_attrs["description"],
            default_value: env_attrs["default"],
            required: env_attrs["required"],
        )

        vars[key] = current_var
      end

      vars
    end

    private

    def manifest_contents
      @_manifest_contents ||= parser.parse
    end

    def parser
      @_parser ||= ParserFactory.parser(Config.mainfest_path)
    end

    def manifest_validator
      @_validator ||= ManifestValidator.new(manifest_contents)
    end
  end
end
