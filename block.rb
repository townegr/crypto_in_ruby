require 'colorize'
require 'digest'

class Block
  attr_reader :prev_blk_hash, :txn

  NONCE_VALUE = 'nMCwCAQACBQDXLocZAgMBAAECBHjwSh0CAwD+JwIDANi/AgMA1xcCAgXNAgJzRA'
  NUM_ZEROES = 5

  def initialize txn, prev_blk
    raise TypeError unless txn.is_a?(Transaction)
    @txn = txn
    @prev_blk_hash = prev_blk.underlying_hash if prev_blk
    self.underlying_hash
  end

  def underlying_hash
    @underlying_hash ||= hash(blk_header nonce)
  end

  def valid?
    valid_nonce?(nonce) && txn.is_valid_signature?
  end

  private

  def hash data
    Digest::SHA256.hexdigest data
  end

  def blk_header nonce_value
    [txn.to_s, prev_blk_hash, nonce_value].compact.join
  end

  def nonce
    @_nonce ||= calc_nonce
  end

  def calc_nonce
    nonce_value = NONCE_VALUE
    count = 0
    unless valid_nonce? nonce_value
      print '.' if count % 100_000 == 0
      nonce_value = nonce_value.next
      count += 1
    end
    nonce_value
  end

  def valid_nonce? nonce_value
    hash(blk_header nonce_value).start_with? leading_zeroes
  end

  def leading_zeroes
    '0' * NUM_ZEROES
  end
end
