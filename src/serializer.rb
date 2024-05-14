require 'json'

#-----------------------------------------------------------------
# TESTS
# request = '{"status": %s, "username": "%s"}' % [100, "Gavriel"]
# puts request
# j = JSON.parse(request) # can access j['status'], j['username']
#-----------------------------------------------------------------

class Serializer
  # Converts JSON request or response into bytes data
  def initialize

  end

  def self.serialize_login_request (login_request)
    serialized_bytes = Array.new
    serialized_bytes.push([login_request.status].pack('C'))
    json = '{"status": %s, "username": "%s"}' % [login_request.status, login_request.username]
    serialized_bytes.push(*[json.length].pack('Q').bytes)
    serialized_bytes.push(*json.bytes)

    return serialized_bytes
  end

  def self.serialize_send_message_request (send_message_request)
    serialized_bytes = Array.new
    serialized_bytes.push([send_message_request.status].pack('C'))
    json = '{"status": %s, "sender": "%s", "message": %s}' % [send_message_request.status, send_message_request.sender, send_message_request.message]
    serialized_bytes.push(*[json.length].pack('Q').bytes)
    serialized_bytes.push(*json.bytes)

    return serialized_bytes
  end

  def self.serialize_logout_request (logout_request)
    serialized_bytes = Array.new
    serialized_bytes.push([logout_request.status].pack('C'))
    json = '{"status": %s, "username": "%s"}' % [logout_request.status, logout_request.username]
    serialized_bytes.push(*[json.length].pack('Q').bytes)
    serialized_bytes.push(*json.bytes)

    return serialized_bytes
  end

  def self.serialize_login_response (login_response)

  end

  def self.serialize_send_message_response (send_message_response)

  end

  def self.serialize_logout_response (logout_response)

  end
end
