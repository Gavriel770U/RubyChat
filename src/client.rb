require 'socket'

SERVER_PORT = 8888

$client = TCPSocket.open('localhost', SERVER_PORT)
$username = ""
$is_running = true
$is_logged = false

while $is_running
  if $is_logged != true
    print "Enter username: "
    $username = gets.chomp
    $is_logged = true
    $message = "Hello from #{$username} :)"
    $client.puts $message
  else
    print "Enter message to send: "
    $message = gets.chomp

    if $message == "LOGOUT"
      $client.puts $message
      $is_logged = false
    elsif $message == "EXIT"
      $message = "LOGOUT"
      $client.puts $message
      $is_logged = false
      $is_running = false
      break
    else
      $message = "#{$username}: #{$message}"
      $client.puts $message
    end
  end
end

$client.close

# Itay Hamelech!
