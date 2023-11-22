import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:iz_web_flutter/constant/app_constants.dart';
import 'package:iz_web_flutter/flame_game/multiplayer_game/multiplayer_game.dart';
import 'package:iz_web_flutter/widget/navigation_widget.dart';
import 'package:iz_web_flutter/widget/scaffold/web_responsive_scaffold.dart';

class MultiplayerGameScreen extends StatefulWidget {
  const MultiplayerGameScreen({super.key});

  @override
  State<MultiplayerGameScreen> createState() => _MultiplayerGameScreenState();
}

class _MultiplayerGameScreenState extends State<MultiplayerGameScreen> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Size screenSize = MediaQuery.of(context).size;
    return WebResponsiveScaffold(
        navigationWidget: NavigationWidget(
          menuCode: MenuCodes.MULTIGAME,
          showBackColor: true,
        ),
        backgroundColor: Colors.black87,
        body: Column(children: [
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.white70)),
            child: AspectRatio(
                aspectRatio: 640 / 368,
                child: GameWidget(
                  game: MultiplayerGame(),
                )),
          )
        ])
        // Column(
        //   children: [
        //     SizedBox(
        //       height: 30,
        //     ),
        //     Container(
        //       width: double.infinity,
        //       height: 400,
        //       decoration: BoxDecoration(border: Border.all(color: Colors.white70)),
        //       child: Stack(
        //
        //         children: [
        //         Positioned(child: Icon(Icons.adb_sharp,color: Colors.white70,size: 32,))
        //       ],),
        //     )
        //   ],
        // ),
        );
  }
}
