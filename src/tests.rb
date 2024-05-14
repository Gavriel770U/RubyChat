require_relative 'requests'
require_relative 'serializer'
require_relative 'deserializer'

lr = LoginRequest.new(100, "Gavriel123")
print "Original struct: "
puts lr
bytes_data = Serializer.serialize_login_request(lr)
new_lr = Deserializer.deserialize_login_request(bytes_data)
print "New struct: "
puts new_lr
