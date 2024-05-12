LoginRequest = Struct.new(:status, :username) do

end

SendMessageRequest = Struct.new(:status, :sender, :message) do

end

LogoutRequest = Struct.new(:status, :username) do

end
