import 'package:flutter/material.dart';
import 'package:iz_web_flutter/widget/scaffold/web_responsive_scaffold.dart';

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
    return WebResponsiveScaffold(
      navigationWidget: NavigationWidget(showBackColor: true,),
      body: ReceiptPage(),
    );
  }
}
