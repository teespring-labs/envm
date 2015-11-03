require "envm/config"
require "envm/parser"

module Envm
  class ManifestLoader
    def self.load
      contents = parser.parse

      vars = {}
      contents.each_key do |key|
        env_attrs = contents[key]

        current_var = EnvVar.new(
            name: key,
            description: env_attrs["description"],
            default_values: env_attrs["default"],
            set_value_required: env_attrs["set_value_required"],
        )

        vars[key] = current_var
      end

      vars
    end

    def self.parser
      @_parser ||= ParserFactory.parser(Config.manifest_path)
    end
  end
end
