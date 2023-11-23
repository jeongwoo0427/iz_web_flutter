import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

class AnotherPlayer extends CircleComponent {
  static const playerSize = 23;


  AnotherPlayer({required position})
      : super(position: position, radius: 23, anchor: Anchor.center,);


  double moveSpeed = 250; //실제 플레이어 속도보다 조금 느려야 버벅거리는 느낌이 사라진다.
  double horizontalMovement = 0;
  double verticalMovement = 0;
  Vector2 velocity = Vector2.zero();

  late Vector2 destinyPosition ;

  @override
  Future<void> onLoad() {
    setColor(Colors.orangeAccent);
    destinyPosition = this.position;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _moveToDestiny(dt);
    super.update(dt);
  }

  final EffectController con = EffectController(duration: 10,);

  int i=0;
  late MoveToEffect effect;
  void updatePlayerPosition(Vector2 newPosition) {

    destinyPosition = newPosition;
    //print(i.toString());
    // i++;
    // if(i >= 10){
    //   destinyPosition = newPosition;
    //   i=0;
    // }
    //position = newPosition;
  }

  void _moveToDestiny(dt) {

    horizontalMovement = 0;
    verticalMovement = 0;



    if(position.x<destinyPosition.x-3) {
      horizontalMovement = 1;
    }else if(position.x  >destinyPosition.x+3){
      horizontalMovement = -1;
    }

    if(position.y<destinyPosition.y-3) {
      verticalMovement = 1;
    }else if(position.y  >destinyPosition.y+3){
      verticalMovement = -1;
    }


    velocity.x = horizontalMovement * moveSpeed;
    velocity.y = verticalMovement * moveSpeed;
    position.x += velocity.x * dt;
    position.y += velocity.y * dt;

  }

}
