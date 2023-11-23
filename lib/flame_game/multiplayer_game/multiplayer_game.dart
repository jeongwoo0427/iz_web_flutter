import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:iz_web_flutter/core/service/socket/game_socket_service.dart';

import 'component/another_player.dart';
import 'component/player.dart';

class MultiplayerGame extends FlameGame with HasKeyboardHandlerComponents {
  final GameSocketService socketService = GameSocketService();
  final Map<String, AnotherPlayer> anotherPlayers = {};

  @override
  Color backgroundColor() {
    return Colors.transparent;
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  @override
  Future<void> onLoad() async {
    socketService.connect();
    final socket = socketService.socket;
    final Player myPlayer = Player(position: Vector2(double.parse(Random().nextInt(200).toString()), double.parse(Random().nextInt(200).toString())));
    add(myPlayer);

    socket.emit('joinRoom', [
      {'positionX': myPlayer.x, 'positionY': myPlayer.y}
    ]);

    //addAnother();
    socket.on('roomJoined', (data) {
      print(data);
      for(int i = 0; i<data.length; i++){
        String socketId = data[i]['socketId'];
        if(socket.id != socketId && anotherPlayers[socketId]==null){
          anotherPlayers[socketId] = AnotherPlayer(position: Vector2(data[i]['positionX'],data[i]['positionY']));
          add(anotherPlayers[socketId]!);
        }
      }
    });


    socket.on('playerUpdated', (data) {
      String anotherId = data['socketId'];
      if(anotherId != socket.id){
        anotherPlayers[anotherId]?.updatePlayerPosition(Vector2(data['positionX'], data['positionY'])) ;
      }
    });

    socket.on('roomQuit',(data){
      String socketId = data;
      remove(anotherPlayers[socketId]!);
      anotherPlayers.remove(socketId);
    });

    return super.onLoad();
  }

}
