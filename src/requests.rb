module RequestCode
  LOGIN = 10
  SEND_MESSAGE = 20
  LOGOUT = 30
  REFRESH = 40
end

LoginRequest = Struct.new(:status, :username) do

end

SendMessageRequest = Struct.new(:status, :sender, :message) do

end

RefreshRequest = Struct.new(:status) do

end

LogoutRequest = Struct.new(:status, :username) do

end
