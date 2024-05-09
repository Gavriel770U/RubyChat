require 'socket'

SERVER_PORT = 8888

server = TCPServer.new(SERVER_PORT)

loop do
  client = server.accept
  message = server.gets
  print "#Client sent: {message}"
  client.close
end
