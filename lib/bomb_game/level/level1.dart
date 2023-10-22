
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:iz_web_flutter/bomb_game/bomb_game.dart';

class Level1 extends World{

  late final TiledComponent tiledMap;

  @override
  Future<void> onLoad() async {

    tiledMap = await TiledComponent.load('map1.tmx',prefix:BombGame.assetPrefix, Vector2.all(64));
    add(tiledMap);

    return super.onLoad();
  }


}