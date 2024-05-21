require 'socket'

module SocketUtilsSettings
  SEND_FLAGS = 0
  CODE_BYTES_SIZE = 1
  LENGTH_BYTES_SIZE = 8
end

class SocketUtils
  def self.send(socket, bytes_data)
    socket.send(bytes_data.pack('C*'), SocketUtilsSettings::SEND_FLAGS)
  end

  def self.recv(socket)
    bytes_data = Array.new
    code_byte = socket.read(SocketUtilsSettings::CODE_BYTES_SIZE).unpack('C')
    length_bytes = socket.read(SocketUtilsSettings::LENGTH_BYTES_SIZE).unpack('C*')
    message_bytes = socket.read(length_bytes.pack('C*').unpack('Q').first).unpack('C*')
    bytes_data.push(*code_byte)
    bytes_data.push(*length_bytes)
    bytes_data.push(*message_bytes)
    return bytes_data
  end
end
