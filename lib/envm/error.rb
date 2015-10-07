module Envm
  class EnvmError < StandardError; end
  class NotFoundError < EnvmError; end
  class NotSetError < EnvmError; end
  class FileNotFoundError < EnvmError; end
  class FileTypeNotSupportedError < EnvmError; end
end
