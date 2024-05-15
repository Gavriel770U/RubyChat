require 'tk'

class Chat
   def initialize
      @root = TkRoot.new(title: "RubyChat", geometry: "600x400")
      @root.resizable(false, false)

      @messages = Array.[]("Hello!", "Heya", "Bye...", "Ooofff, please don't go!", "I", "Love", "Ruby", "And", "Hate", "Tkinter", "More", "More...", "Ooofff, please don't go!", "I", "Love", "Ruby", "And", "Hate", "Tkinter", "More", "More...", "Even More!", "And more", "Hiii", "Kill Tk", "GitHub cool", "Ruby")

      wrapper1 = Tk::Tile::Frame.new (@root) {
         relief 'sunken'
         borderwidth 3
         place('width' => 500, 'height' => 250, 'x' => 50, 'y' => 10)
      }

      wrapper2 = Tk::Tile::Frame.new (@root) {
         place('width' => 500, 'height' => 250, 'x' => 50, 'y' => 10)
      }

      @chat_canvas = TkCanvas.new(wrapper1)
      @chat_canvas.pack(:side => "left", :fill => "both", :expand => "yes")

      yscrollbar = TkScrollbar.new(:parent => wrapper1, :command => Proc.new {|*args| @chat_canvas.yview *args})
      yscrollbar.pack(:side => "left", :fill => "y")

      @chat_canvas.configure(:yscrollcommand => Proc.new {|*args| yscrollbar.set *args })
      @chat_canvas.bind("Configure", Proc.new {@chat_canvas.scrollregion = @chat_canvas.bbox("all")})

      @chat_frame = Tk::Tile::Frame.new (@chat_canvas) { }
      TkcWindow.new(@chat_canvas, 0, 0, :anchor => "nw", :window => @chat_frame)

      # this pady controls the chat frame's padding from top (used also to change height)
      wrapper1.pack(:fill => "both", :expand => "yes", :padx => 10, :pady => 10)
      # this pady controls the chat frame's padding from bottom (used also to change height)
      wrapper2.pack(:fill => "both", :expand => "yes", :padx => 10, :pady => 40)

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
         label.pack()

         y += 80
      end

      @separator = Tk::Tile::Separator.new(@root) do
         orient 'horizontal'
         place('width' => 500, 'x' => 50, 'y' => 320)
      end

      send_message_command = proc { self.send_message }

      @message_entry = TkEntry.new(@root)
      @message_variable = TkVariable.new
      @message_entry.textvariable = @message_variable
      @message_entry.place('height' => 25, 'width' => 300, 'x' => 50, 'y' => 340)
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

      @send_message_button.place('height' => 25, 'width' => 25, 'x' => 380, 'y' => 340)
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

chat = Chat.new
chat.run
