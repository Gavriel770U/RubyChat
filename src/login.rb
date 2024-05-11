require 'tk'

class LoginWindow
  def initialize
    @root = TkRoot.new(title: "[RubyChat] Login", geometry: "600x400")
    @root.resizable(false, false)

    @login_label = TkLabel.new (@root) do
      text "Login"
      foreground "red"
      font TkFont.new('consolas 20 bold')
      borderwidth 2
      justify "center"
    end

    @login_label.place('x' => 250, 'y' => 50)

    @username_label = TkLabel.new (@root) do
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



  end

  def run
    Tk.mainloop
  end
end

login_window = LoginWindow.new
login_window.run
