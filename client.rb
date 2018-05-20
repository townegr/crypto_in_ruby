require_relative 'g_coin'
require 'faraday'

URL = 'http://localhost'
PORT = 4567

def create_user name
  Faraday.post("#{origin}/users", name: name).body
end

def get_balance user
  Faraday.get("#{origin}/balance", user: user).body
end

def transfer from, to, amount
  Faraday.post("#{origin}/transfers", from: from, to: to, amount: amount).body
end

def origin
  "#{URL}:#{PORT}"
end
