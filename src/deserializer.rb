require 'json'

class Deserializer
  # Converts bytes data into JSON,
  # and then builds requests and responses out of it.

  def initialize

  end

  def self.deserialize_login_request (bytes_data)
    length = bytes_data[1..8].pack('C*').unpack('Q').first
    json = JSON.parse([9..9+length-1].pack('C*'))
    lr = LoginRequest.new(json['status'], json['username'])
    return lr
  end

  def self.deserialize_send_message_request (bytes_data)

  end

  def self.deserialize_logout_request (bytes_data)

  end

  def self.deserialize_login_response (bytes_data)

  end


  def self.deserialize_send_message_response (bytes_data)

  end

  def self.deserialize_logout_response (bytes_data)

  end
end
