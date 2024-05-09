require 'socket'

SERVER_PORT = 8888

client = TCPSocket.open('localhost', SERVER_PORT)
is_running = true

loop do
  if is_running != true
    break
  end

  print "Enter username: "
  username = gets.chomp
  message = "Hello from #{username} :)"
  client.puts message
end

client.close
