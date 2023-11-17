import 'package:flutter/material.dart';
import 'package:iz_web_flutter/constant/app_constants.dart';
import 'package:iz_web_flutter/core/state/socket_state.dart';
import 'package:iz_web_flutter/widget/navigation_widget.dart';
import 'package:iz_web_flutter/widget/scaffold/web_responsive_scaffold.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final IO.Socket _socket = SocketState().socket;

  @override
  void initState() {
    //print('initState');
    _socket.emit('joinRoom', [{
      "roomCode":"code1234",
      "user":{
        "id":"jwkim1234",
        "name":"크크루삥뽕",
      }
    }]);
    _socket.on('event', (data) => print(data));
    _socket.on('fromServer', (_) => print(_));
    _socket.on('error',(data) => print(data));
    _socket.on('hey',(data)=>print('hey ${data}'));
    _socket.onDisconnect((_) => print('disconnect'));


    super.initState();
  }

  @override
  void dispose() {
    _socket.emit('quitRoom', [{
      "roomCode":"code1234",
      "user":{
        "id":"jwkim1234",
        "name":"크크루삥뽕",
      }
    }]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebResponsiveScaffold(
      navigationWidget: NavigationWidget(
        menuCode: MenuCodes.CHAT,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
