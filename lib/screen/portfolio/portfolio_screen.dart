import 'package:flutter/material.dart';

import '../../widget/navigation_widget.dart';
import 'banner_page.dart';
import 'info_page.dart';
import 'stacks_page.dart';


class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  ScrollController _scrollController = ScrollController();

  final banner1Key = GlobalKey();
  final banner2Key = GlobalKey();
  final banner3Key = GlobalKey();

  bool isTop = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 80 && isTop == true) {
        setState(() {
          isTop = false;
        });
      } else if (_scrollController.offset <= 80 && isTop == false) {
        setState(() {
          isTop = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_circle_down_sharp),
        onPressed: () {
          //Scrollable.ensureVisible(banner2Key.currentContext!, curve: Curves.decelerate, duration: Duration(milliseconds: 500));
        },
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Listener(
                onPointerDown: (event) {
                  print('onPointerDown');
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: [
                    BannerPage(
                      key: banner1Key,
                    ),
                    InfoPage(),
                    StacksPage(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: NavigationWidget(
              showBackColor: !isTop,
            ),
          ),
        ],
      ),
    );
  }
}
