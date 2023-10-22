
import 'package:flame/cache.dart';
import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';

import 'level/level1.dart';

class BombGame extends FlameGame{

  static const String assetPrefix = 'assets/game/bomb/';

  late final CameraComponent cam;

  final Level1 level1 = Level1();



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