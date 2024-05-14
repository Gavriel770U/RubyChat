require 'tk'

class Chat
   def initialize
      @root = TkRoot.new(title: "RubyChat", geometry: "600x400")
      @root.resizable(false, false)

      @messages = Array.[]("Hello!", "Heya", "Bye...", "Ooofff, please don't go!")

      @chat_frame = TkFrame.new (@root) {
         relief 'sunken'
         borderwidth 3
         padx 15
         pady 20
         background "white"
         place('width' => 500, 'height' => 250, 'x' => 50, 'y' => 10)
      }

      x = 10
      y = 10

      @messages.each do |message|
         label = TkLabel.new (@chat_frame) do
            text message
            foreground "white"
            font TkFont.new('consolas 12 bold')
            background "red"
            borderwidth 2
         end

         label.place('x' => x, 'y' => y)

         y += 40
      end

      @separator = Tk::Tile::Separator.new(@root) do
         orient 'horizontal'
         place('width' => 500, 'x' => 50, 'y' => 280)
      end

      send_message_command = self.send_message

      @message_entry = TkEntry.new(@root)
      @message_variable = TkVariable.new
      @message_entry.textvariable = @message_variable
      @message_entry.place('height' => 25, 'width' => 300, 'x' => 50, 'y' => 300)
      # Bind Enter key press to send message also
      @message_entry.bind('Return', send_message_command)

      @send_message_button = TkButton.new(@root) do
         text ">"
         borderwidth 2
         state "normal"
         foreground "red"
         activebackground "red"
         command send_message_command
      end

      @send_message_button.place('height' => 25, 'width' => 25, 'x' => 380, 'y' => 300)

   end

   def run
      Tk.mainloop
   end

   def send_message
      if !@message_variable.value.nil? && !@message_variable.value.empty?
         puts @message_variable.value
         @message_variable.value = ""
      end
   end
end
