module Affine
  # The affine cipher for positive integers.  This algorithm is only defined
  # for positive integers, and many arguments have further restrictions.
  #
  # == Usage
  #
  #   @a = Affine::Cipher.new(2176782371, 65182241782, 123235151)
  #   ct = @a.encipher(14)
  #   14 == @a.decipher(ct)
  class Cipher

    # Cipher objects are used both for decryption and encryption.
    #
    # == Arguments
    # [+modulus+] specifies how many different plaintexts and ciphertexts
    #             are available.
    # [+a_key+] multiplied against the plaintext. <b>Must be coprime with
    #           +modulus+.</b>
    # [+b_key+] added to the multiplied plaintext.  No restrictions, but
    #           it's modulus math, so making it larger than +modulus+ is
    #           useless.
    def initialize(modulus, a_key, b_key)
      raise CoprimeError.new(modulus, a_key) if modulus.gcd(a_key) != 1
      @modulus = modulus
      @a_key = a_key
      @b_key = b_key
      @a_inv = extended_gcd(a_key, modulus)
    end

    # Encrypt one +plaintext+ into a +ciphertext+.
    def encipher(plaintext)
      raise RangeError.new(plaintext, @modulus) if plaintext > @modulus
      ((@a_key * plaintext) + @b_key) % @modulus
    end

    # Decrypt one +ciphertext+ into a +plaintext+.
    def decipher(ciphertext)
      raise RangeError.new(ciphertext, @modulus) if ciphertext > @modulus
      (@a_inv * (ciphertext - @b_key)) % @modulus
    end

    alias_method :encrypt, :encipher
    alias_method :decrypt, :decipher
    private
    # from http://snippets.dzone.com/posts/show/6074
    def extended_gcd(b,m,_recursion_depth=0)
      if b % m == 0
        temp = [0,1]
        return temp
      else
        temp = extended_gcd(m, b % m, _recursion_depth+1)
        temp2 = [temp[1], temp[0]-temp[1] * ((b/m).to_i)]
        if _recursion_depth == 0
          return temp2[0] % m
        else
          return temp2
        end
      end
    end
  end
end
