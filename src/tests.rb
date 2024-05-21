require_relative 'requests'
require_relative 'serializer'
require_relative 'deserializer'

lr = LoginRequest.new(RequestCode::LOGIN, "Gavriel123")
print "Original struct: "
puts lr
bytes_data = Serializer.serialize_login_request(lr)
new_lr = Deserializer.deserialize_login_request(bytes_data)
print "New struct: "
puts new_lr


arr = Array.new
arr.push("Hello")
arr.push("Boogo")
arr.push("Hi")

#puts arr.to_json.class

refr = RefreshResponse.new(ResponseCode::REFRESH_SUCCESS, arr)
print "Original struct: "
puts refr
bytes_data = Serializer.serialize_refresh_request(lr)
new_refr = Deserializer.deserialize_refresh_request(bytes_data)
print "New struct: "
puts refr
