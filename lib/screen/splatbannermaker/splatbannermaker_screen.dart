import 'package:flutter/material.dart';

import '../../widget/navigation_widget.dart';
import 'receipt_page.dart';

class SplatBannerMakerScreen extends StatefulWidget {
  const SplatBannerMakerScreen({Key? key}) : super(key: key);

  @override
  State<SplatBannerMakerScreen> createState() => _SplatBannerMakerScreenState();
}

class _SplatBannerMakerScreenState extends State<SplatBannerMakerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          NavigationWidget(showBackColor: true,),
          Expanded(child: ReceiptPage())
        ],
      ),
    );
  }
}
