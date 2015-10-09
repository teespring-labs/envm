module Envm
  class EnvmError < StandardError; end
  class NotFoundError < EnvmError; end
  class NotSetError < EnvmError; end
  class FileTypeNotSupportedError < EnvmError; end
  class MalformedManifestError < EnvmError; end
  class ManifestNotSetError < EnvmError; end
  class ManifestNotFoundError < EnvmError; end
end
