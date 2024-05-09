require 'socket'

SERVER_PORT = 8888

client = TCPSocket.open('localhost')

username = gets.chomp
message = "Hello from #{username} :)"
client.puts message

client.close
