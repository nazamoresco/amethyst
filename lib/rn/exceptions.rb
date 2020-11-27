module RN
  module Exceptions
    class ModelException < Exception; end
    class MissingNote < ModelException; end
    class MissingBook < ModelException; end
    class ExistingNote < ModelException; end
    class ExistingBook < ModelException; end
    class InvalidTitle < ModelException; end
    class InvalidFormat < ModelException; end
  end
end
