import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:iz_web_flutter/core/service/socket/game_socket_service.dart';

import 'component/player.dart';

class MultiplayerGame extends FlameGame with HasKeyboardHandlerComponents{

  GameSocketService socketService = GameSocketService();

  @override
  Color backgroundColor() {
    return Colors.transparent;
  }

  @override
  Future<void> onLoad() async {
    socketService.connect();
    final socket = socketService.socket;
    final Player player1 = Player(position: Vector2(40, 40));
    add(player1);
    //addAnother();
    socket.on('roomJoined',(data){

    });

    socket.on('playerUpdated',(data){

    });

    return super.onLoad();
  }

  Future<void> addAnother() async {
    await Future.delayed(Duration(milliseconds: 4400));
    final Player player2 = Player(position: Vector2(80, 50));
    add(player2);
    await Future.delayed(Duration(milliseconds: 4400));
    final Player player3 = Player(position: Vector2(170, 90));
    add(player3);
  }
}
