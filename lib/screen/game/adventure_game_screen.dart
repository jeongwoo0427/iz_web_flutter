import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:iz_web_flutter/constant/app_constants.dart';
import 'package:iz_web_flutter/widget/navigation_widget.dart';
import 'package:iz_web_flutter/widget/scaffold/web_responsive_scaffold.dart';

import '../../flame_game/adventure_game/pixel_adventure.dart';


class BombGameScreen extends StatefulWidget {
  const BombGameScreen({super.key});

  @override
  State<BombGameScreen> createState() => _BombGameScreenState();
}

class _BombGameScreenState extends State<BombGameScreen> {
  @override
  Widget build(BuildContext context) {
    return WebResponsiveScaffold(
      navigationWidget: NavigationWidget(menuCode: MenuCodes.GAME,showBackColor: true ),
      body: Column(
        children: [
          SizedBox(height: 50,),
          AspectRatio(
              aspectRatio: 640/368,child: GameWidget(game: PixelAdventure(),))
        ],
      ),
    );
  }
}
