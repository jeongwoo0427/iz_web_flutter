import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnotherPlayer extends CircleComponent {
  static const playerSize = 23;


  AnotherPlayer({required position})
      : super(position: position, radius: 23, anchor: Anchor.center,);


  double moveSpeed = 300;
  double horizontalMovement = 0;
  double verticalMovement = 0;
  Vector2 velocity = Vector2.zero();

  @override
  Future<void> onLoad() {
    setColor(Colors.orangeAccent);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void updatePlayerPosition(Vector2 newPosition) {
    position = newPosition;
  }

}
