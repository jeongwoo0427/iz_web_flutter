import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:iz_web_flutter/bomb_game/bomb_game.dart';
import 'package:iz_web_flutter/widget/navigation_widget.dart';
import 'package:iz_web_flutter/widget/scaffold/web_responsive_scaffold.dart';

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
              aspectRatio: 1024/768,child: GameWidget(game: BombGame(),))
        ],
      ),
    );
  }
}
