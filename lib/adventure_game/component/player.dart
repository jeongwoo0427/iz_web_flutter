import 'package:flame/components.dart';
import 'package:iz_web_flutter/adventure_game/adventure_game.dart';
import 'package:iz_web_flutter/adventure_game/component/utils.dart';

import 'collision_block.dart';

enum PlayerState {
  idle,
  running,
}


class Player extends SpriteAnimationGroupComponent
    with HasGameRef<AdventureGame>, KeyboardHandler {
  // 최상위 수준의 게임클래스를 참조하기 위해 Mixin으로 선언

  String character;

  Player({required this.character, required position})
      : super(position: position){
    debugMode = true;
  }

  //Animation Variables
  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _runningAnimation;

  double horizontalMovement = 0;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();

  //Player객체는 직접 본인의 collision들을 알아야 한다.
  List<CollisionBlock> collisionBlocks = [];

  @override
  Future<void> onLoad() async {
    _loadAllAnimations();
    return super.onLoad();
  }

  //업데이트는 매 프레임마다 호출되며 컴퓨터의 프레임이 초당 10Fps일 경우 초당 10번 호출된다.
  //dt : DeltaTime을 의미하며 프레임 사이의 속도를 나타낸다
  @override
  void update(double dt) {
    _updatePlayerState();
    _updatePlayerMovement(dt);
    _checkHorizontalCollisions();
    super.update(dt);
  }


  void _loadAllAnimations() {
    _idleAnimation =
        _loadAnimation(character: character, state: 'Idle', amount: 11);
    //캐릭터로 쓸 스프라이트 이미지를 불러와 idleAnimation 변수에 저장한다.

    _runningAnimation =
        _loadAnimation(character: character, state: 'Run', amount: 12);

    animations = {
      PlayerState.idle: _idleAnimation,
      PlayerState.running: _runningAnimation
    };
    //상속받은 animations객체에 PlayerState와 애니메이션을 Map구조로 넣어둔다.

    current = PlayerState.idle; //현재의 애니메이션 상태를 idle로 둠.
    //current = PlayerState.running;
  }

  SpriteAnimation _loadAnimation(
      {required String character,
        required String state,
        required int amount,
        double stepTime = 0.06}) {
    return SpriteAnimation.fromFrameData(
      game.images
          .fromCache('Images/Main Characters/${character}/${state} (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    if(velocity.x < 0 && scale.x > 0){
      flipHorizontallyAroundCenter();
    }else if(velocity.x >0 && scale.x <0){
      flipHorizontallyAroundCenter();
    }
    if(horizontalMovement==-1||horizontalMovement == 1) playerState = PlayerState.running;

    current = playerState;
  }

  void _updatePlayerMovement(double dt) {

    velocity.x = horizontalMovement * moveSpeed;
    position.x += velocity.x * dt;
    //만약 프레임이 낮아지게 되면 프레임 간 dt가 커지게 되고 다음 position의 값은 커지게 되므로
    //프레임 간섭에 의한 이동속도 차이가 사라지게 된다.
  }

  void _checkHorizontalCollisions() {
    for(int i = 0 ; i < collisionBlocks.length; i++){
      final block = collisionBlocks[i];
      if(!block.isPlatform && checkCollision(this, block)){
        if(velocity.x > 0){
          velocity.x = 0;
          position.x = block.x - width;
        }
        if(velocity.x < 0){
          velocity.x = 0;
          position.x = block.x +block.width;
        }
      }
    }
  }


}