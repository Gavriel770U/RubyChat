require 'tk'

def send_message
   puts $message_entry.value
   $message_entry.value = ""
end

root = TkRoot.new(title: "RubyChat", geometry: "600x400")

separator = Tk::Tile::Separator.new(root) do
   orient 'horizontal'
   place('width' => 400, 'x' => 50, 'y' => 280)
end

$message_entry = TkEntry.new(root)
$message_variable = TkVariable.new
$message_entry.textvariable = $message_variable
$message_entry.place('height' => 25, 'width' => 300, 'x' => 50, 'y' => 300)

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
