lr = LoginRequest.new(100, "Gavriel123")
puts lr
bytes_data = Serializer.serialize_login_request(lr)
new_lr = Deserializer.deserialize_login_request(bytes_data)
puts new_lr
