import 'package:flame/components.dart';
import 'package:flutter/services.dart';

import '../adventure_game.dart';

enum PlayerState {
  idle,
  running,
}

enum PlayerMovementDirection { left, right, none }

enum PlayerFacingDirection { left, right }

class Player extends SpriteAnimationGroupComponent with HasGameRef<AdventureGame> , KeyboardHandler{
  String character;

  Player({this.character = 'Mask Dude', required position}) : super(position: position);

  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _runningAnimation;

  PlayerMovementDirection playerMoveDirection = PlayerMovementDirection.none;
  PlayerFacingDirection playerFacingDirection = PlayerFacingDirection.right;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();

  @override
  Future<void> onLoad() async {
    _loadAllAnimations();

    return super.onLoad();
  }

  @override
  void update(double dt) {
    updatePlayerMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // TODO : 반드시 최상위 게임 클래스에 HasKeyboardHandlerComponents mixin을 해줘야 사용이 가능하다.
    final bool isLeftKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyA) ||
            keysPressed.contains(LogicalKeyboardKey.arrowLeft);

    final bool isRightKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyD) ||
            keysPressed.contains(LogicalKeyboardKey.arrowRight);

    playerMoveDirection = PlayerMovementDirection.none;
    if (isLeftKeyPressed && isRightKeyPressed) {
      playerMoveDirection = PlayerMovementDirection.none;
    } else if (isLeftKeyPressed) {
      playerMoveDirection = PlayerMovementDirection.left;
    } else if (isRightKeyPressed) {
      playerMoveDirection = PlayerMovementDirection.right;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimations() {
    _idleAnimation = loadAnimation(character: character, state: 'Idle', amount: 11);

    _runningAnimation = loadAnimation(character: character, state: 'Run', amount: 12);

    animations = {PlayerState.idle: _idleAnimation, PlayerState.running: _runningAnimation};
    //상속받은 animations객체에 PlayerState와 애니메이션을 Map구조로 넣어둔다.

    current = PlayerState.idle; //현재의 애니메이션 상태를 idle로 둠.
    //current = PlayerState.running;
  }

  // SpriteAnimation loadAnimation(
  //     {required String character,
  //       required String state,
  //       required int amount,
  //       double stepTime = 0.06}) {
  //   return SpriteAnimation.fromAsepriteData(
  //     game.images
  //         .fromCache('1-Player-Bomb Guy/1-Player-Bomb Guy.aseprite'),
  //   );
  // }
  //
  SpriteAnimation loadAnimation({required String character, required String state, required int amount, double stepTime = 0.06}) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Images/Main Characters/Mask Dude/${state} (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  void updatePlayerMovement(double dt) {
    double dirX = 0.0;

    switch (playerMoveDirection) {
      case PlayerMovementDirection.left:
        if (playerFacingDirection == PlayerFacingDirection.right) {
          flipHorizontallyAroundCenter();
          playerFacingDirection = PlayerFacingDirection.left;
        } //우측을 보고 있을 경우 뒤집어서 왼쪽을 보게끔
        current = PlayerState.running;
        dirX -= moveSpeed;

        break;
      case PlayerMovementDirection.right:
        if (playerFacingDirection == PlayerFacingDirection.left) {
          flipHorizontallyAroundCenter();
          playerFacingDirection = PlayerFacingDirection.right;
        } //왼쪽을 보고 있을 경우 뒤집어서 오른쪽을 보게끔
        current = PlayerState.running;
        dirX += moveSpeed;
        break;
      case PlayerMovementDirection.none:
        current = PlayerState.idle;
        break;

      default:
    }

    velocity = Vector2(dirX*dt, 0.0);
    position += velocity;
  }
}
