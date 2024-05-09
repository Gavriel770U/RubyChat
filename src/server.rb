require 'socket'

SERVER_PORT = 8888

server = TCPServer.new('localhost', SERVER_PORT)

puts "Running server..."

loop do
  Thread.start(server.accept) do |client|
    is_running = true
    while is_running
      message = client.gets

      if !message.nil? && !message.empty?
        puts "Client sent: #{message}"
        if message == "LOGOUT"
          client.close
          is_running = false
          Thread.kill
          Thread.exit
        end
      end
    end
  end
end

server.close
