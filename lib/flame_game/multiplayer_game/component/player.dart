import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iz_web_flutter/core/service/socket/game_socket_service.dart';

class Player extends CircleComponent with KeyboardHandler{

  static const playerSize = 23;

  Player({required position})
      : super(position: position, radius: 23, anchor: Anchor.center);

  final _socket = GameSocketService().socket;

  double moveSpeed = 300;
  double horizontalMovement = 0;
  double verticalMovement = 0;
  Vector2 velocity = Vector2.zero();

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    _socket.emit('updatePlayer',[{
      'positionX': this.x, 'positionY': this.y
    }]);
    super.update(dt);
  }
  void _updatePlayerMovement(double dt) {

    // if (velocity.y > _gravity) isOnGround = false; // optional

    velocity.x = horizontalMovement * moveSpeed;
    velocity.y = verticalMovement * moveSpeed;
    position.x += velocity.x * dt;
    position.y += velocity.y * dt;
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;
    verticalMovement = 0;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    final isDownKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyS)||
        keysPressed.contains(LogicalKeyboardKey.arrowDown);
    final isUpKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyW)||
        keysPressed.contains(LogicalKeyboardKey.arrowUp);

    horizontalMovement += isLeftKeyPressed ? -1 : 0;
    horizontalMovement += isRightKeyPressed ? 1 : 0;
    verticalMovement += isUpKeyPressed ? -1 : 0;
    verticalMovement += isDownKeyPressed ? 1 : 0;


    return super.onKeyEvent(event, keysPressed);
  }


}
