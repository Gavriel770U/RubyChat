require 'socket'

SERVER_PORT = 8888

server = TCPServer.new('localhost', SERVER_PORT)

puts "Running server..."

loop do
  Thread.start(server.accept) do |client|
    message = client.gets
    puts "Client sent: #{message}"
    if message == "LOGOUT"
      client.close
    end
  end
end

server.close
