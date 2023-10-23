
import 'package:flame/components.dart';

import '../adventure_game.dart';



enum PlayerState {
  idle,
  running,
}

class Player extends SpriteAnimationGroupComponent with HasGameRef<AdventureGame>{

  String character;

  Player({this.character = 'Mask Dude', required position}) : super(position: position);

  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _runningAnimation;

  @override
  Future<void> onLoad() async {

    _loadAllAnimations();

    return super.onLoad();
  }


  void _loadAllAnimations() {
    _idleAnimation = loadAnimation(character: character, state: 'Idle', amount: 11);

    _runningAnimation = loadAnimation(character: character, state: 'Run', amount: 12);

    animations = {
      PlayerState.idle: _idleAnimation,
      PlayerState.running: _runningAnimation
    };
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
  SpriteAnimation loadAnimation(
      {required String character,
        required String state,
        required int amount,
        double stepTime = 0.06}) {
    return SpriteAnimation.fromFrameData(
      game.images
          .fromCache('Images/Main Characters/Mask Dude/${state} (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

}