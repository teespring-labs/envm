module Envm
  class ManifestValidator
    attr_accessor :contents

    def initialize(contents)
      self.contents = contents
    end

    def valid?
      return false unless contents.is_a?(Hash)

      contents.each do |_, v|
        return false unless v.is_a?(Hash)
      end

      true
    end
  end
end
