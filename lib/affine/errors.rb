module Affine
  class AffineError < StandardError
  end
  class CoprimeError < AffineError
    def initialize(a, b)
      super("Expected #{a} to be coprime with #{b}")
    end
  end
  class RangeError < AffineError
    def initialize(n, mod)
      super("Expected input #{n} to be smaller than modulus #{mod}")
    end
  end
end
