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
    debugMode = false;
  }

  //Animation Variables
  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _runningAnimation;

  double horizontalMovement = 0; //움직임 방향 -1 : 좌 , 1 : 우 , 0 : 정지
  double moveSpeed = 100; //움직임 속도
  Vector2 velocity = Vector2.zero();
  final double _gravity = 18.5;//중력
  final double _jumpForce = 400;//점프력
  final double _terminalVelocity = 400; //최대추락속도
  bool isOnGround = false;
  bool hasJumped = false;

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
    _applyHorizontalCollisions();
    _applyGravity(dt);
    _applyVerticalCollisions();
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
    if(hasJumped && isOnGround) _playerJump(dt);

    velocity.x = horizontalMovement * moveSpeed;
    position.x += velocity.x * dt;
    //만약 프레임이 낮아지게 되면 프레임 간 dt가 커지게 되고 다음 position의 값은 커지게 되므로
    //프레임 간섭에 의한 이동속도 차이가 사라지게 된다.
  }

  void _applyHorizontalCollisions() {
    for(int i = 0 ; i < collisionBlocks.length; i++){
      final block = collisionBlocks[i];
      if(!block.isPlatform && checkCollision(this, block)){
        if(velocity.x > 0){
          velocity.x = 0;
          position.x = block.x - width;
        }
        if(velocity.x < 0){
          velocity.x = 0;
          position.x = block.x +block.width + width;
        }
      }
    }
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;

    velocity.y = velocity.y.clamp(-_jumpForce, _terminalVelocity); //위로가는 속도와 아래로 가는 속도의 한계를 셋팅함
    position.y += velocity.y * dt;
  }

  void _applyVerticalCollisions() {
    isOnGround = false;
    for(int i = 0 ; i < collisionBlocks.length; i++){
      final block = collisionBlocks[i];
      if(block.isPlatform){//플래폼은 밑에서 위로 관통할 수 있어야 하므로 위에 닿을때의 액션은 제외됨.
        if(checkCollision(this, block)){//바닥에 닿았을 경우 더이상 하강하지 못하도록
          velocity.y = 0;
          position.y = block.y - width;
          isOnGround = true;
          break;
        }
      }else{
        if(checkCollision(this, block)){
          if(velocity.y > 0){//바닥에 닿았을 경우 더이상 하강하지 못하도록
            velocity.y = 0;
            position.y = block.y - width;
            isOnGround = true;
            break;
          }

          if(velocity.y < 0){//천장에 닿았을 경우 더이상 승강하지 못하도록
            velocity.y = 0;
            position.y = block.y + block.height;
          }
        }
      }
    }
  }

  void _playerJump(double dt) {
    velocity.y = -_jumpForce;
    position.y += velocity.y * dt;
    isOnGround = false;
    hasJumped = false;
  }


}