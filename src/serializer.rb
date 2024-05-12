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
    puts login_request
  end

  def self.serialize_send_message_request (send_message_request)

  end

  def self.serialize_logout_request (logout_request)

  end

  def self.serialize_login_response (login_response)

  end

  def self.serialize_send_message_response (send_message_response)

  end

  def self.serialize_logout_response (logout_response)

  end
end
