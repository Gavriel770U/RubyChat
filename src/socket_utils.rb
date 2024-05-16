require 'socket'

module SocketUtilsSettings
  SEND_FALGS = 0
  CODE_BYTES_SIZE = 1
  LENGTH_BYTES_SIZE = 8
end

class SocketUtils
  def self.send(socket, bytes_data)
    socket.send(bytes_data.pack('C*'), SocketUtilsSettings::SEND_FALGS)
  end

  def self.recv(socket)
    bytes_data = Array.new
    code_byte = client.read(SocketUtilsSettings::CODE_BYTES_SIZE).unpack('C')
    length_bytes = client.read(SocketUtilsSettings::LENGTH_BYTES_SIZE).unpack('C*')
    message_bytes = client.read(length_bytes.pack('C*').unpack('Q').first).unpack('C*')
    bytes_data.push(code_byte)
    bytes_data.push(*length_bytes)
    bytes_data.push(*message_bytes)
  end
end
