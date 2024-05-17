require 'json'
require_relative 'requests'
require_relative 'responses'

class Serializer
  # Converts requests and responses into JSON,
  # and then converts the request or response JSON into bytes data

  def initialize

  end

  def self.serialize_login_request (login_request)
    serialized_bytes = Array.new
    serialized_bytes.push(login_request.status)
    json = '{"status": %s, "username": "%s"}' % [login_request.status, login_request.username]
    serialized_bytes.push(*[json.length].pack('Q').bytes)
    serialized_bytes.push(*json.bytes)

    return serialized_bytes
  end

  def self.serialize_send_message_request (send_message_request)
    serialized_bytes = Array.new
    serialized_bytes.push(send_message_request.status)
    json = '{"status": %s, "sender": "%s", "message": "%s"}' % [send_message_request.status, send_message_request.sender, send_message_request.message]
    serialized_bytes.push(*[json.length].pack('Q').bytes)
    serialized_bytes.push(*json.bytes)

    return serialized_bytes
  end

  def self.serialize_logout_request (logout_request)
    serialized_bytes = Array.new
    serialized_bytes.push(logout_request.status)
    json = '{"status": %s, "username": "%s"}' % [logout_request.status, logout_request.username]
    serialized_bytes.push(*[json.length].pack('Q').bytes)
    serialized_bytes.push(*json.bytes)

    return serialized_bytes
  end

  def self.serialize_login_response (login_response)
    serialized_bytes = Array.new
    serialized_bytes.push(login_response.status)
    json = '{"status": %s}' % [login_response.status]
    serialized_bytes.push(*[json.length].pack('Q').bytes)
    serialized_bytes.push(*json.bytes)

    return serialized_bytes
  end

  def self.serialize_send_message_response (send_message_response)
    serialized_bytes = Array.new
    serialized_bytes.push(send_message_response.status)
    json = '{"status": %s}' % [send_message_response.status]
    serialized_bytes.push(*[json.length].pack('Q').bytes)
    serialized_bytes.push(*json.bytes)

    return serialized_bytes
  end

  def self.serialize_logout_response (logout_response)
    serialized_bytes = Array.new
    serialized_bytes.push(logout_response.status)
    json = '{"status": %s}' % [logout_response.status]
    serialized_bytes.push(*[json.length].pack('Q').bytes)
    serialized_bytes.push(*json.bytes)

    return serialized_bytes
  end
end
