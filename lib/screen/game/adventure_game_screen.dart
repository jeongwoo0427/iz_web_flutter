import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:iz_web_flutter/widget/navigation_widget.dart';
import 'package:iz_web_flutter/widget/scaffold/web_responsive_scaffold.dart';

import '../../adventure_game/adventure_game.dart';

class BombGameScreen extends StatefulWidget {
  const BombGameScreen({super.key});

  @override
  State<BombGameScreen> createState() => _BombGameScreenState();
}

class _BombGameScreenState extends State<BombGameScreen> {
  @override
  Widget build(BuildContext context) {
    return WebResponsiveScaffold(
      navigationWidget: NavigationWidget(showBackColor: true ),
      body: Column(
        children: [
          SizedBox(height: 50,),
          AspectRatio(
              aspectRatio: 640/368,child: GameWidget(game: AdventureGame(),))
        ],
      ),
    );
  }
}
