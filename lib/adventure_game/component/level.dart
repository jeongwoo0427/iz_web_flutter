import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:iz_web_flutter/adventure_game/component/collision_block.dart';

import 'player.dart';
import '../adventure_game.dart';

class Level extends World {
  final String mapName;
  final Player player;

  Level({required this.mapName, required this.player});

  late final TiledComponent level;
  final List<CollisionBlock> collisionBlocks = [];

  @override
  Future<void> onLoad() async {
    level = await TiledComponent.load(
        '${mapName}.tmx', prefix: AdventureGame.assetPrefix, Vector2.all(16));
    add(level);

    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('spawnpoints');
    //spawnpoints 라는 레이어를 가져온다

    //spawnpoints 레이어의 모든 객체들을 가져온다.
    if (spawnPointsLayer != null) {
      for (int i = 0; i < (spawnPointsLayer.objects.length); i++) {
        final spawnPoint = spawnPointsLayer.objects[i];
        switch (spawnPoint.class_) {
          case 'player': //클래스이름을 기준으로 switch 분기
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            //플레이어의 부모클래스로부터 상속받은 position 객체에 현재 spawnPoint 객체의 x,y 좌표를 넣음
            add(player);
            break;

          default:
        }
      }
    }

    //collisions 레이어를 가져온다.
    final collisionsLayer = level.tileMap.getLayer<ObjectGroup>('collisions');
    if (collisionsLayer != null) {
      for (int i = 0; i < (collisionsLayer.objects.length); i++) {
        print(i);
        final collision = collisionsLayer.objects[i];
        switch (collision.class_) {
          case 'platform': //클래스이름을 기준으로 switch 분기
            final platform = CollisionBlock(
                position: Vector2(collision.x, collision.y),
                size: Vector2(collision.width, collision.height),
                isPlatform: true);
            collisionBlocks.add(platform);
            add(platform);
            break;

          default:
            final block = CollisionBlock(
              position: Vector2(collision.x,collision.y),
              size:  Vector2(collision.width,collision.height),
            );
            collisionBlocks.add(block);
            add(block);
        }
      }
    }

    player.collisionBlocks = collisionBlocks;

    return super.onLoad();
  }
}
