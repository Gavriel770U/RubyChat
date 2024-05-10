require 'tk'

root = TkRoot.new(title: "RubyChat", geometry: "600x400")

message_entry = TkEntry.new(root)
message_variable = TkVariable.new
message_entry.textvariable = message_variable
message_entry.place('height' => 25, 'width' => 300, 'x' => 50, 'y' => 300)



Tk.mainloop
