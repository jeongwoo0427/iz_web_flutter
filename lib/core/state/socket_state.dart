import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketState {
  late IO.Socket _socket;

  IO.Socket get socket => _socket;

  static final SocketState _instance = SocketState._internal();

  factory SocketState() {
    return _instance;
  }

  SocketState._internal() {
    _socket = IO.io('http://182.172.171.168:34', IO.OptionBuilder().disableAutoConnect().build());

    _socket.onConnect((_)=>print('Socket Connected!'));

    print('SocketState is created');
  }

  void connect(){
    if(_socket.connected == false){
      _socket.connect();
    }
  }


}
