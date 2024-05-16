require 'socket'
require_relative 'login'
require_relative 'chat'

SERVER_PORT = 8888

class Client
  def initialize
    @client_socket = TCPSocket.open('localhost', SERVER_PORT)
    @username = ""
    @is_running = false
    @is_logged = false
  end

  def run
    chat = Chat.new(@client_socket)

    if !@is_logged
      login_window = LoginWindow.new(@client_socket, chat)
      login_window.run()
    end
    login_window.destroy
    chat.run()

    self.close
  end


  def close
    @client_socket.close
  end
end

client = Client.new()
client.run()
