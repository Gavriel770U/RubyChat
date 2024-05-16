require 'socket'
require 'tk'
require_relative 'requests'
require_relative 'serializer'
require_relative 'deserializer'

class LoginWindow
  def initialize(socket, next_window)
    @socket = socket
    @next_window = next_window

    @root = TkRoot.new(title: "[RubyChat] Login", geometry: "600x400")
    @root.resizable(false, false)
    @root.protocol("WM_DELETE_WINDOW", proc { self.close })

    @login_label = TkLabel.new(@root) do
      text "Login"
      foreground "red"
      font TkFont.new('consolas 20 bold')
      borderwidth 2
      justify "center"
    end
    @login_label.place('x' => 250, 'y' => 50)

    @username_label = TkLabel.new(@root) do
      text "Username"
      foreground "red"
      font TkFont.new('consolas 16 bold')
      borderwidth 2
      justify "center"
    end
    @username_label.place('x' => 250, 'y' => 120)

    @username_entry = TkEntry.new(@root)
    @username_variable = TkVariable.new
    @username_entry.textvariable = @username_variable
    @username_entry.place('height' => 25, 'width' => 200, 'x' => 200, 'y' => 160)

    submit_command = proc { self.submit }

    @submit_button = TkButton.new(@root) do
      text "Submit"
      borderwidth 2
      state "normal"
      foreground "red"
      activebackground "red"
      font TkFont.new('consolas 12 bold')
      command submit_command
    end
    @submit_button.place('x' => 260, 'y' => 300)
  end

  def run
    @root.mainloop
  end

  def submit
    if @username_variable.value.nil? || @username_variable.value.empty?
      Tk.messageBox(
        'type'    => "ok",
        'icon'    => "error",
        'title'   => "[RubyChat] Error",
        'message' => "Invalid credentials!"
      )
      return
    end

    puts @username_variable.value

    login_request = LoginRequest.new(RequestCode::LOGIN, @username_variable.value)
    bytes_data = Serializer.serialize_login_request(login_request)

    @socket.send(bytes_data.pack('C*'), 0)

    bytes_data = Array.new
    code_byte = @socket.read(1).unpack('C')
    length_bytes = @socket.read(8).unpack('C*')
    message_bytes = @socket.read(length_bytes.pack('C*').unpack('Q').first).unpack('C*')
    bytes_data.push(code_byte)
    bytes_data.push(*length_bytes)
    bytes_data.push(*message_bytes)
    login_response = Deserializer.deserialize_login_response(bytes_data)

    @username_variable.value = ""

    if ResponseCode::LOGIN_SUCCESS == login_response['status']
      self.close
    else
      Tk.messageBox(
        'type'    => "ok",
        'icon'    => "error",
        'title'   => "[RubyChat] Error",
        'message' => "Failed to Login!"
      )
    end
  end

  def close
    puts "Exit..."
    if !@next_window.nil?
      @root.withdraw
      @next_window.show
    else
      @root.destroy
    end
  end

  def destroy
    @root.destroy
  end

end
