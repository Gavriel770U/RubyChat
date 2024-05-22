# RubyChat
Chat in Ruby and Tkinter GUI

____________________________________________________

# Protocol
RubyChat uses it's own protocol of messages which uses different status codes.

The basic structure of any response or request that can be found in `responses.rb` or `requests.rb`:

| **Field**      | Status Code | Json Message Length | Json Message Content        | 
| -------------- | ----------- | ------------------- | --------------------------- |
| **Bytes Size** | 1 Byte      | 8 Bytes             | `Json Message Length` Bytes |

____________________________________________________


# Install Dependencies
## Windows
Make sure you have bundler:
```
bundler -v
```

If you do not have bundler:
```
gem install bundler
```

When you are done, install the gems needed for the project:
```
bundle install
```

## Linux
Make sure you have bundler:
```
bundler -v
```

If you do not have bundler:
```
gem install bundler
```

When you are done, install the gems needed for the project:
```
bundle install
```

If there are issues with Tkinter try installing Tk or Tcl manually