import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'component/player.dart';
import 'component/level.dart';

class AdventureGame extends FlameGame with HasKeyboardHandlerComponents {
  static const String assetPrefix = 'assets/game/adventure/';
  late final CameraComponent cam;
  late final JoystickComponent joystick;
  late Level level;
  late Player player;
  bool showJoystic = false;

  @override
  Color backgroundColor() {
    return const Color(0xff161423); //백그라운드 색깔 적용하여 타일맵에서 빈 공간에는 백그라운듯 색이 보이게 된다
  }

  @override
  Future<void> onLoad() async {
    assets.prefix = assetPrefix;
    images.prefix = assetPrefix;
    await images.loadAllImages();
    //성능 이슈를 해결하기 위해 미리 최상위 게임 클래스에서 모든 asset 이미지들을 불러온다
    //이미지를 사용하려면 앞으로 HasGameRef<PixelAdventure>를 mixin을 하여 game.images.fromCache('Main characters/Ninja Frog/Idle (32x32).png')
    //형식으로 이미지를 가져와 사용하도록 하자
    player = Player(character: 'Mask Dude', position: Vector2.zero());
    level = Level(player: player, mapName: 'map1');
    add(level);

    initJoystick();

    //우선순위는 항상 Camera>HUD>World>Others 로 이뤄져 있음
    //따라서 HUD가 카메라 바로 다음으로 오게끔 카메라컴포넌트의 hudComponents 인자에 HUD 컴포넌트를 추가하면 된다.
    cam = CameraComponent.withFixedResolution(
      hudComponents: [if (showJoystic) joystick],
      world: level,
      width: 640,
      height: 368,
      //해당 월드의 해상도와 맞게 적용해야 한다. New Map 을 할때 Map Size를 정하는데,
      //그때 밑에 표시된 해상도를 똑같이 적용하면 된다.
    );

    cam.viewfinder.anchor = Anchor.topLeft; //카메라 고정을 왼쪽 위로 하도록 함.

    add(cam);
    //addAll([cam, level]);
    //또는 addAll([cam,myWorld]); 도 가능

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showJoystic) {
      updateJoystic();
    }
    super.update(dt);
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // TODO : 반드시 최상위 게임 클래스에 HasKeyboardHandlerComponents mixin을 해줘야 사용이 가능하다.

    final bool isLeftKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyA) ||
            keysPressed.contains(LogicalKeyboardKey.arrowLeft);

    final bool isRightKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyD) ||
            keysPressed.contains(LogicalKeyboardKey.arrowRight);

    player.horizontalMovement = 0;
    if(isLeftKeyPressed) player.horizontalMovement = -1;
    if(isRightKeyPressed) player.horizontalMovement = 1;

    player.hasJumped = keysPressed.contains(LogicalKeyboardKey.space);

    return super.onKeyEvent(event, keysPressed);
  }

  void initJoystick(
      {double knobOpacity = 0.3, double backgroundOpacity = 0.5}) {
    //knob의 스프라이트 컴포넌트객체를 추가한다.
    final knobSprite = SpriteComponent(
      size: Vector2.all(30),
      sprite: Sprite(images.fromCache('Images/HUD/knob.png')),
    );
    //추가된 스프라이트 컴포넌트 객체의 색깔을 투명하게 조절한다.
    knobSprite.setColor(Colors.transparent.withOpacity(1 - knobOpacity));

    final backgroundSprite = SpriteComponent(
        size: Vector2.all(80),
        sprite: Sprite(images.fromCache('Images/HUD/joystick.png')));
    backgroundSprite
        .setColor(Colors.transparent.withOpacity(1 - backgroundOpacity));

    joystick = JoystickComponent(
        priority: 3,
        knob: knobSprite,
        background: backgroundSprite,
        position: Vector2(60, 280));
  }

  void updateJoystic() {
    player.horizontalMovement = 0;
    switch (joystick.direction) {
      case JoystickDirection.downLeft:
      case JoystickDirection.upLeft:
      case JoystickDirection.left:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.downRight:
      case JoystickDirection.upRight:
      case JoystickDirection.right:
        player.horizontalMovement = 1;
        break;
      case JoystickDirection.up:
        break;
      case JoystickDirection.down:
        break;
    }
  }
}
