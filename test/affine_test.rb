require 'test_helper'

class AffineTest < Test::Unit::TestCase
  context 'affine cipher 5,8 mod 26' do
    setup do
      @a = Affine::Cipher.new(26, 5, 8)
    end

    should 'be created correctly' do
      assert_nothing_raised do
        Affine::Cipher.new(26, 5, 8)
      end
    end

    should 'encipher ITSCOOL correctly' do
      # example from http://en.wikipedia.org/wiki/Affine_cipher
      plain = 'ITSCOOL'.split('').map{ |c| c[0] - 65}
      coded = plain.map{ |c| @a.encipher c }
      check ='WZUSAAL'.split('').map{ |c| c[0] - 65}
      assert_equal check, coded
    end
    should 'decipiher WZUSAAL correctly' do
      # example from http://en.wikipedia.org/wiki/Affine_cipher
      check ='WZUSAAL'.split('').map{ |c| c[0] - 65}
      coded = check.map{ |c| @a.decipher c }
      plain = 'ITSCOOL'.split('').map{ |c| c[0] - 65}
      assert_equal plain, coded
    end
  end

  context 'affine cipher 65182241782, 123235151 mod 2176782371' do
    setup do
      @a = Affine::Cipher.new(2176782371, 65182241782, 123235151)
    end
    should 'get created correctly' do
      assert_nothing_raised do
        Affine::Cipher.new(2176782371, 65182241782, 123235151)
      end
    end
    should 'pass a few random identity checks' do
      # I'm not doing this by hand
      1000.times do
        r = rand(123235150)
        assert_equal r, @a.decipher(@a.encipher(r))
      end
    end
  end
end
