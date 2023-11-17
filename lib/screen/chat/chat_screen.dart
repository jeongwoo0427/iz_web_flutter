import 'package:flutter/material.dart';
import 'package:iz_web_flutter/constant/app_constants.dart';
import 'package:iz_web_flutter/widget/navigation_widget.dart';
import 'package:iz_web_flutter/widget/scaffold/web_responsive_scaffold.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final IO.Socket socket = IO.io(
      'http://182.172.171.168:34',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build());

  @override
  void initState() {
    socket.connect();
    socket.onConnect((_) {
      print('connected');
      socket.emit('joinRoom', [{
        "roomCode":"code12334",
        "user":{
          "id":"jwkim1234",
          "name":"크크루삥뽕",
        }
      }]);
    });
    socket.on('event', (data) => print(data));
    socket.on('fromServer', (_) => print(_));
    socket.on('error',(data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));

    super.initState();
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
