require 'tk'

class LoginWindow
  def initialize
    @root = TkRoot.new(title: "[RubyChat] Login", geometry: "600x400")
    @root.resizable(false, false)
  end

  def run
    Tk.mainloop
  end
end

login_window = LoginWindow.new
login_window.run
