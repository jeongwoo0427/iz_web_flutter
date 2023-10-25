
import 'package:flame/cache.dart';
import 'package:flame/camera.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';

import 'level/level.dart';

class AdventureGame extends FlameGame with HasKeyboardHandlerComponents{

  static const String assetPrefix = 'assets/game/adventure/';

  late final CameraComponent cam;

  final Level level1 = Level(mapName: 'map1');



  @override
  Future<void> onLoad() async {

    assets.prefix = assetPrefix;
    images.prefix = assetPrefix;
    await images.loadAllImages();

    
    cam = CameraComponent.withFixedResolution(width: 640, height: 368, world: level1);

    cam.viewfinder.anchor = Anchor.topLeft;

    add(cam);
    add(level1);

    
    return super.onLoad();
  }
  
}