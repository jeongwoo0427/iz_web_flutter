import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatSocketState {
  late IO.Socket _socket;

  IO.Socket get socket => _socket;

  static final ChatSocketState _instance = ChatSocketState._internal();

  factory ChatSocketState() {
    return _instance;
  }

  ChatSocketState._internal() {
    _socket = IO.io('http://182.172.171.168:34', IO.OptionBuilder().disableAutoConnect().setPath('/chat').build());

    _socket.onConnect((_)=>print('Socket Connected!'));

    print('SocketState is created');
  }

  void connect(){
    if(_socket.connected == false){
      _socket.connect();
    }
  }


}
