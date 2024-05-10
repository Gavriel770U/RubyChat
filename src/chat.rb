require 'tk'

def send_message
   if !$message_variable.value.nil? && !$message_variable.value.empty?
      puts $message_variable.value
      $message_variable.value = ""
   end
end

root = TkRoot.new(title: "RubyChat", geometry: "600x400")
root.resizable(false, false)

chat_frame = TkFrame.new (root) {
   relief 'sunken'
   borderwidth 3
   padx 15
   pady 20
   background "white"
   place('width' => 500, 'height' => 250, 'x' => 50, 'y' => 10)
}

separator = Tk::Tile::Separator.new(root) do
   orient 'horizontal'
   place('width' => 500, 'x' => 50, 'y' => 280)
end

$message_entry = TkEntry.new(root)
$message_variable = TkVariable.new
$message_entry.textvariable = $message_variable
$message_entry.place('height' => 25, 'width' => 300, 'x' => 50, 'y' => 300)
# Bind Enter key press to send message also
$message_entry.bind('Return', (proc {send_message}))

$send_message_button = TkButton.new(root) do
   text ">"
   borderwidth 2
   state "normal"
   foreground "red"
   activebackground "red"
   command (proc {send_message})
end

$send_message_button.place('height' => 25, 'width' => 25, 'x' => 380, 'y' => 300)

Tk.mainloop
