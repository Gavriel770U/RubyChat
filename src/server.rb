require 'socket'
require_relative 'responses'
require_relative 'serializer'
require_relative 'deserializer'
require_relative 'logged_user'

SERVER_PORT = 8888

server = TCPServer.new('localhost', SERVER_PORT)
logged_users = Array.new

def find_logged_user(target_logged_user, logged_users)
  logged_users.each do |logged_user|
    if logged_user.username == target_logged_user.username
      return true
    end
  end

  return false
end

puts "Running server..."

loop do
  Thread.start(server.accept) do |client|
    puts "Accepted client"
    is_running = true
    while is_running
      bytes_data = Array.new
      code_byte = client.read(1).unpack('C')
      length_bytes = client.read(8).unpack('C*')
      message_bytes = client.read(length_bytes.pack('C*').unpack('Q').first).unpack('C*')
      bytes_data.push(code_byte)
      bytes_data.push(*length_bytes)
      bytes_data.push(*message_bytes)
      login_request = Deserializer.deserialize_login_request(bytes_data)
      puts login_request

      logged_user = LoggedUser.new(login_request['username'])
      user_exists = find_logged_user(logged_user, logged_users)
      if !user_exists
        login_reponse = LoginResponse.new(ResponseCode::LOGIN_SUCCESS)
        logged_users.push(logged_user)
      else
        login_reponse = LoginResponse.new(ResponseCode::LOGIN_FAILURE)
      end

      bytes_data = Serializer.serialize_login_response(login_reponse)
      client.send(bytes_data.pack('C*'), 0)
    end

    client.close
    Thread.exit
  end
end

server.close
