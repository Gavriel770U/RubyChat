module ResponseCode
  LOGIN_SUCCESS = 11
  LOGIN_FAILURE = 12
  SEND_MESSAGE_SUCCESS = 21
  LOGOUT_SUCCESS = 31
  REFRESH_SUCCESS = 41
  REFRESH_FAILURE = 42
end

LoginResponse = Struct.new(:status) do

end

SendMessageResponse = Struct.new(:status) do

end

RefreshResponse = Struct.new(:status, :new_messages) do

end

LogoutResponse = Struct.new(:status) do

end
