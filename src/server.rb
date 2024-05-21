require 'socket'
require_relative 'socket_utils'
require_relative 'responses'
require_relative 'serializer'
require_relative 'deserializer'
require_relative 'logged_user'

SERVER_PORT = 8888

$users_hash_map = Hash.new
$messages_for_refresh_map = Hash.new
$all_messages = Array.new # for new logged user

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
    logged_user = nil

    while is_running
      bytes_data = SocketUtils.recv(client)

      if RequestCode::LOGIN == bytes_data.at(0)
        login_request = Deserializer.deserialize_login_request(bytes_data)
        puts login_request

        login_response = nil

        if is_logged
          login_reponse = LoginResponse.new(ResponseCode::LOGIN_FAILURE)
        else
          logged_user = LoggedUser.new(login_request['username'])
          user_exists = find_logged_user(logged_user, logged_users)
          if !user_exists
            login_reponse = LoginResponse.new(ResponseCode::LOGIN_SUCCESS)
            logged_users.push(logged_user)
            is_logged = true
            $users_hash_map[logged_user] = client
            $messages_for_refresh_map[logged_user] = Queue.new
            print $users_hash_map
          else
            login_reponse = LoginResponse.new(ResponseCode::LOGIN_FAILURE)
          end
        end

        bytes_data = Serializer.serialize_login_response(login_reponse)
        SocketUtils.send(client, bytes_data)

      elsif RequestCode::SEND_MESSAGE == bytes_data.at(0)
        send_message_request = Deserializer.deserialize_send_message_request(bytes_data)
        puts send_message_request

        $messages_for_refresh_map.each_key do |logged_user_key|
          if logged_user_key != logged_user
            $messages_for_refresh_map[logged_user_key] << send_message_request['message']
          end
        end
        puts $messages_for_refresh_map

        send_message_response = SendMessageResponse.new(ResponseCode::SEND_MESSAGE_SUCCESS)
        bytes_data = Serializer.serialize_send_message_response(send_message_response)
        SocketUtils.send(client, bytes_data)

      elsif RequestCode::REFRESH == bytes_data.at(0)
        refresh_request = Deserializer.deserialize_refresh_request(bytes_data)
        puts refresh_request

        refresh_response = nil
        messages_to_send = Array.new

        if is_logged
          while !$messages_for_refresh_map[logged_user].empty? do
            messages_to_send.push($messages_for_refresh_map[logged_user].pop)
          end

          refresh_response = RefreshResponse.new(ResponseCode::REFRESH_SUCCESS, messages_to_send)

        elsif
          refresh_response = RefreshResponse.new(ResponseCode::REFRESH_FAILURE, messages_to_send)
        end

        bytes_data = Serializer.serialize_refresh_response(refresh_response)
        SocketUtils.send(client, bytes_data)

      elsif RequestCode::LOGOUT == bytes_data.at(0)
        logout_request = Deserializer.deserialize_logout_request(bytes_data)
        puts logout_request

        is_running = false
        is_logged = false
        key_to_delete = :logged_user
        $users_hash_map.delete(key_to_delete)
        $messages_for_refresh_map.delete(key_to_delete)
        logged_users.delete(logged_user)

        logout_response = LogoutResponse.new(ResponseCode::LOGOUT_SUCCESS)
        bytes_data = Serializer.serialize_logout_response(logout_response)
        SocketUtils.send(client, bytes_data)
      end
    end

    client.close
    Thread.exit
  end
end

server.close
