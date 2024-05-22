# RubyChat
Chat in Ruby and Tkinter GUI

____________________________________________________

# Protocol
RubyChat uses it's own protocol of messages which uses different status codes.

**The basic structure of any response or request that can be found in `responses.rb` or `requests.rb`:**

| **Field**      | Status Code | Json Message Length | Json Message Content        | 
| -------------- | ----------- | ------------------- | --------------------------- |
| **Bytes Size** | 1 Byte      | 8 Bytes             | `Json Message Length` Bytes |

**Status Codes Table:**

| **Value** | **Meaning**                     |
| --------- | ------------------------------- |
| **10**    | Login Request                   |
| **11**    | Login Success Response          |
| **12**    | Login Failure Response          |
| **20**    | Send Message Request            |
| **21**    | Send Message Success Response   |
| **30**    | Logout Request                  |
| **31**    | Logout Success Response         |
| **40**    | Refresh Request                 |
| **41**    | Refresh Success Response        |
| **42**    | Refresh Failure Response        |

____________________________________________________


# Install Dependencies
## Windows
Make sure you have bundler:
```cmd
bundler -v
```

If you do not have bundler:
```cmd
gem install bundler
```

When you are done, install the gems needed for the project:
```cmd
bundle install
```

## Linux
Make sure you have bundler:
```console
bundler -v
```

If you do not have bundler:
```console
gem install bundler
```

When you are done, install the gems needed for the project:
```console
bundle install
```

If there are issues with Tkinter try installing Tk or Tcl manually

____________________________________________________

# Features & TODO

[x] Create basic client-server model
[x] Create multi-threaded server that accepts multiple clients
[x] Create GUI for Login
[x] Create GUI for Chat
[x] Create Responses
[x] Create Request
[x] Create Serializer for the requests and responses to json and then to bytes array
[x] Create Deserializer for the bytes arrays to json to responses and requests
[x] Create Socket Utils class for easier data sending and receiving process with the responses and requests
[x] Merge login networking with GUI
[x] Merge send message networking with GUI
[x] Create refresh thread of the messages got after login
[x] Create logout
[ ] Get history of messages that were sent before login since server is running
[ ] Prettify the messages in GUI