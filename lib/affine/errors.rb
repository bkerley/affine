module Affine

  # Parent class for Affine cipher errors.
  #
  # This is a good kind of error to rescue when you're not
  # sure about the key, modulus, plaintext, or ciphertext
  # and want to fail cleanly.
  class AffineError < StandardError
  end

  # Raised when two numbers that are supposed to be coprime
  # (greatest common denominator of 1) are not.
  #
  # Keys and moduli from external sources might raise these.
  class CoprimeError < AffineError
    def initialize(a, b) #:nodoc:
      super("Expected #{a} to be coprime with #{b}")
    end
  end

  # Raised when an input number is larger than the modulus.
  #
  # Plaintexts or ciphertexts from external sources might
  # raise these.
  class RangeError < AffineError
    def initialize(n, mod) #:nodoc:
      super("Expected input #{n} to be smaller than modulus #{mod}")
    end
  end
end
