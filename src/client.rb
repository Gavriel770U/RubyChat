require 'socket'

SERVER_PORT = 8888

client = TCPSocket.open('localhost', SERVER_PORT)

print "Enter username: "
username = gets.chomp
message = "Hello from #{username} :)"
client.puts message

client.close
