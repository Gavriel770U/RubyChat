require 'socket'
require_relative 'Serializer'
require_relative 'Deserializer'

SERVER_PORT = 8888

server = TCPServer.new('localhost', SERVER_PORT)

puts "Running server..."

loop do
  Thread.start(server.accept) do |client|
    puts "Accepted client"
    is_running = true
    while is_running
      bytes_data = Array.new
      code_byte = client.read(1).unpack('C')
      length_bytes = client.read(8).unpack('C*')
      message_bytes = client.read(length_bytes.pack('C*').unpack('Q').first).unpack('C*')
      bytes_data.push(code_byte)
      bytes_data.push(*length_bytes)
      bytes_data.push(*message_bytes)
      login_request = Deserializer.deserialize_login_request(bytes_data)
      puts login_request

      client.close
      Thread.exit
    end
  end
end

server.close
