require 'json'
require_relative 'requests'
require_relative 'responses'

class Deserializer
  # Converts bytes data into JSON,
  # and then builds requests and responses out of it.

  def initialize

  end

  def self.deserialize_login_request (bytes_data)
    length = bytes_data[1..8].pack('C*').unpack('Q').first
    json = JSON.parse(bytes_data[9..9+length-1].pack('C*'))
    lr = LoginRequest.new(json['status'], json['username'])

    return lr
  end

  def self.deserialize_send_message_request (bytes_data)
    length = bytes_data[1..8].pack('C*').unpack('Q').first
    json = JSON.parse(bytes_data[9..9+length-1].pack('C*'))
    smr = SendMessageRequest.new(json['status'], json['sender'], json['message'])

    return smr
  end

  def self.deserialize_logout_request (bytes_data)
    length = bytes_data[1..8].pack('C*').unpack('Q').first
    json = JSON.parse(bytes_data[9..9+length-1].pack('C*'))
    lr = LogoutRequest.new(json['status'], json['username'])

    return lr
  end

  def self.deserialize_login_response (bytes_data)
    length = bytes_data[1..8].pack('C*').unpack('Q').first
    json = JSON.parse(bytes_data[9..9+length-1].pack('C*'))
    lr = LoginResponse.new(json['status'])

    return lr
  end


  def self.deserialize_send_message_response (bytes_data)
    length = bytes_data[1..8].pack('C*').unpack('Q').first
    json = JSON.parse(bytes_data[9..9+length-1].pack('C*'))
    smr = SendMessageResponse.new(json['status'])

    return smr
  end

  def self.deserialize_logout_response (bytes_data)

  end
end
