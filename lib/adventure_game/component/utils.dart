import 'package:iz_web_flutter/adventure_game/component/collision_block.dart';
import 'package:iz_web_flutter/adventure_game/component/player.dart';

bool checkCollision(Player player, CollisionBlock block) {
  final playerX = player.position.x;
  final playerY = player.position.y;
  final playerWidth = player.width;
  final playerHeight = player.height;

  final blockX = block.x;
  final blockY = block.y;
  final blockWidth = block.width;
  final blockHeight = block.height;

  //플레이어가 왼쪽으로 이동할땐 좌,우 가 뒤집히기 때문에 그에 대한 대처를 함.
  final fixedX = player.scale.x < 0 ? playerX - playerWidth : playerX;


  return (playerY < block.y + blockHeight &&
      playerY + playerHeight > blockY &&
      fixedX < blockX + blockWidth &&
      fixedX + playerWidth > blockX
  );
}
