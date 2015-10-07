require "envm/version"
require "envm/manifest"

module Envm
  DEFAULT_ENV = "default"

  extend self

  def setup
    @manifest = Manifest.new
  end

  def [](name)
    @manifest.fetch(name)
  end
end
