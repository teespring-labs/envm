require 'envm/version'
require 'envm/error'
require 'envm/config'
require 'envm/loader'

module Envm
  extend self

  def setup
    config = Envm::Config.new

    if block_given?
      yield(config)
    end

    if config.manifest_path.nil?
      fail Envm::EnvmError, 'Manifest not configured'
    end

    unless File.exist?(config.manifest_path)
      fail Envm::FileNotFoundError, "#{config.manifest_path} was not found"
    end

    loader = Loader.new(config)
    @manifest = loader.load
  end

  def [](name)
    @manifest.fetch(name)
  end
end
