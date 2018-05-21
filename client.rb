require 'faraday'

class Client
  URL = 'http://localhost'

  def self.gossip port, peers, blockchain
    begin
      Faraday.post("#{origin}/gossip", peers: peers, blockchain: blockchain).body
    rescue Faraday::ConnectionFailed => e
      raise
    end
  end

  def self.get_pub_key port
    Faraday.get("#{origin}/pub_key").body
  end

  def self.send_money port, to, amount
    Faraday.post("#{origin}/send_money", to: to, amount: amount).body
  end

  private

  def origin
    "#{URL}:#{PORT}"
  end
end
