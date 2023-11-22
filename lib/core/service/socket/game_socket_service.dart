import 'package:socket_io_client/socket_io_client.dart' as IO;

class GameSocketService {
  late IO.Socket _socket;

  IO.Socket get socket => _socket;

  static final GameSocketService _instance = GameSocketService._internal();

  factory GameSocketService() {
    return _instance;
  }

  GameSocketService._internal() {
    _socket = IO.io('http://182.172.171.168:34', IO.OptionBuilder().disableAutoConnect().setPath('/game').build());

    _socket.onConnect((_)=>print('Game Socket Connected!'));

    print('SocketState is created');
  }

  void connect(){
    if(_socket.connected == false){
      _socket.connect();
    }
  }


}
