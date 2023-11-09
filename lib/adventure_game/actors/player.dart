import 'package:flame/components.dart';
import 'package:iz_web_flutter/adventure_game/adventure_game.dart';

enum PlayerState {
  idle,
  running,
}

enum PlayerMovementDirection { left, right, none }

enum PlayerFacingDirection { left, right }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<AdventureGame>, KeyboardHandler {
  // 최상위 수준의 게임클래스를 참조하기 위해 Mixin으로 선언

  String character;

  Player({required this.character, required position})
      : super(position: position);

  //Animation Variables
  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _runningAnimation;

  PlayerMovementDirection playerMoveDirection = PlayerMovementDirection.none;
  PlayerFacingDirection _playerFacingDirection = PlayerFacingDirection.right;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();

  @override
  Future<void> onLoad() async {
    _loadAllAnimations();
    return super.onLoad();
  }

  //업데이트는 매 프레임마다 호출되며 컴퓨터의 프레임이 초당 10Fps일 경우 초당 10번 호출된다.
  //dt : DeltaTime을 의미하며 프레임 사이의 속도를 나타낸다
  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
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

  void _updatePlayerMovement(double dt) {
    double dirX = 0.0;

    switch (playerMoveDirection) {
      case PlayerMovementDirection.left:
        if (_playerFacingDirection == PlayerFacingDirection.right) {
          flipHorizontallyAroundCenter();
          _playerFacingDirection = PlayerFacingDirection.left;
        } //우측을 보고 있을 경우 뒤집어서 왼쪽을 보게끔

        current = PlayerState.running;
        dirX -= moveSpeed;
        break;
      case PlayerMovementDirection.right:
        if (_playerFacingDirection == PlayerFacingDirection.left) {
          flipHorizontallyAroundCenter();
          _playerFacingDirection = PlayerFacingDirection.left;
        } //왼쪽을 보고 있을 경우 뒤집어서 오른쪽을 보게끔
        _playerFacingDirection = PlayerFacingDirection.right;
        current = PlayerState.running;
        dirX += moveSpeed;
        break;
      case PlayerMovementDirection.none:
        current = PlayerState.idle;
        break;

      default:
    }

    velocity = Vector2(dirX, 0.0);
    position += velocity * dt;
    //만약 프레임이 낮아지게 되면 프레임 간 dt가 커지게 되고 다음 position의 값은 커지게 되므로
    //프레임 간섭에 의한 이동속도 차이가 사라지게 된다.
  }
}
