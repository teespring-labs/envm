module Envm
  class EnvmError < StandardError; end
  class NotFoundError < EnvmError; end
  class FileNotFoundError < EnvmError; end
end
