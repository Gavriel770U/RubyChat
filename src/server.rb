require 'socket'

SERVER_PORT = 8888

server = TCPServer.new('localhost', SERVER_PORT)

puts "Running server..."

client = server.accept

loop do
  message = client.gets
  puts "Client sent: #{message}"
  if message == "EXIT"
    client.close
    break
  end
end

server.close
