require 'socket'
require 'tk'
require_relative 'requests'
require_relative 'serializer'

class LoginWindow
  def initialize(socket)
    @socket = socket

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
    Tk.mainloop
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

    @username_variable.value = ""
  end

  def close
    puts "Exit..."
    @root.destroy
  end
end
