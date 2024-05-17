require 'socket'
require_relative 'socket_utils'
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
    is_logged = false
    while is_running
      bytes_data = SocketUtils.recv(client)
      print "Got: "
      puts bytes_data
      print "First byte: ", bytes_data.at(0).class

      if !is_logged
        login_request = Deserializer.deserialize_login_request(bytes_data)
        puts login_request

        logged_user = LoggedUser.new(login_request['username'])
        user_exists = find_logged_user(logged_user, logged_users)
        if !user_exists
          login_reponse = LoginResponse.new(ResponseCode::LOGIN_SUCCESS)
          logged_users.push(logged_user)
          is_logged = true
        else
          login_reponse = LoginResponse.new(ResponseCode::LOGIN_FAILURE)
        end

        bytes_data = Serializer.serialize_login_response(login_reponse)
        SocketUtils.send(client, bytes_data)

      elsif RequestCode::SEND_MESSAGE == bytes_data.at(0)
        send_message_request = Deserializer.deserialize_send_message_request(bytes_data)
        puts send_message_request

        # TODO: implement sending message to all users

        send_message_response = SendMessageResponse.new(ResponseCode::SEND_MESSAGE_SUCCESS)
        bytes_data = Serializer.serialize_send_message_response(send_message_response)
        SocketUtils.send(client, bytes_data)
      end
    end

    client.close
    Thread.exit
  end
end

server.close
