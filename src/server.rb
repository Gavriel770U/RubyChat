require 'socket'

SERVER_PORT = 8888

server = TCPServer.new('localhost', SERVER_PORT)

puts "Running server..."

loop do
  client = server.accept
  message = client.gets
  puts "Client sent: #{message}"
  client.close
end

server.close
