require 'faraday'

class Client
  URL = 'http://localhost'

  class << self
    def gossip port, peers, blockchain
      begin
        Faraday.post("#{origin}/gossip", peers: peers, blockchain: blockchain).body
      rescue Faraday::ConnectionFailed => e
        raise
      end
    end

    def get_pub_key port
      Faraday.get("#{origin}/pub_key").body
    end

    def send_money port, to, amount
      Faraday.post("#{origin}/send_money", to: to, amount: amount).body
    end

    private

    def origin
      "#{URL}:#{PORT}"
    end
  end
end
