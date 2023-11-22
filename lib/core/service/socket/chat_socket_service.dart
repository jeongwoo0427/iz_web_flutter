import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatSocketService {
  late IO.Socket _socket;

  IO.Socket get socket => _socket;

  static final ChatSocketService _instance = ChatSocketService._internal();

  factory ChatSocketService() {
    return _instance;
  }

  ChatSocketService._internal() {
    _socket = IO.io('http://182.172.171.168:34', IO.OptionBuilder().disableAutoConnect().build());

    _socket.onConnect((_)=>print('Chat Socket Connected!'));

    print('Chat SocketState is created');
  }

  void connect(){
    if(_socket.connected == false){
      _socket.connect();
    }
  }


}
