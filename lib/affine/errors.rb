module Affine
  class AffineError < StandardError
  end
  class CoprimeError < AffineError
    def initialize(a, b)
      super("Expected #{a} to be coprime with #{b}")
    end
  end
end
