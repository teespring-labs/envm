require "envm/error"
require "yaml"

module Envm
  class ParserFactory
    def self.parser(filepath)
      unless File.exist?(filepath)
        fail FileNotFoundError, "#{filepath} does not exist."
      end

      if filepath.include?(".yml")
        YamlParser.new(filepath)
      else
        fail FileTypeNotSupportedError, "File type is not supported: #{filepath}."
      end
    end
  end

  class Parser
    attr_accessor :filepath

    def initialize(filepath)
      self.filepath = filepath
    end

    def parse
    end
  end

  class YamlParser < Parser
    def parse
      contents = File.read(filepath)
      YAML.load(contents)
    end
  end
end
