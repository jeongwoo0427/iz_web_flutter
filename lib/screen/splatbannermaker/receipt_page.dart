import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iz_web_flutter/core/model/splatbannermaker/banner_model.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'dart:ui' as ui;

import '../../constant/app_assets.dart';
import '../../constant/app_constants.dart';
import '../../constant/route_names.dart';
import '../../widget/button/AlignedMaterialButton.dart';
import '../../widget/button/rounded_elevated_button.dart';
import '../../widget/scaffold/constrained_layout.dart';

class ReceiptPage extends StatefulWidget {
  ReceiptPage({Key? key}) : super(key: key);

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  final GlobalKey genKey = GlobalKey();

  late BannerModel _selectedBanner;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedBanner = BannerModel(name: 'name', fileName: 'tile013.png', rareLevel: 'rareLevel');
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ConstrainedLayout(
      child: DefaultTextStyle(
        style: TextStyle(
          color: colorScheme.onBackground,
          fontWeight: FontWeight.w800,
          fontSize:
              ResponsiveValue<double>(context, defaultValue: 24, valueWhen: [const Condition.smallerThan(name: TABLET, value: 18)]).value,
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: globalHorizonPadding15),
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              '1. 마음에 드는 배경을 골라주세요.',
            ),
            SizedBox(
              height: 30,
            ),
            AlignedMaterialButton(
                onTap: _onTapBanner,
                child: Image.asset(AppAssets.bannerPath + _selectedBanner.fileName,
                    width: ResponsiveValue<double>(context,
                        defaultValue: 600, valueWhen: [const Condition.smallerThan(name: TABLET, value: 400)]).value)),
            SizedBox(
              height: 100,
            ),
            Text(
              '2. 배찌를 선택해 주세요',
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AlignedMaterialButton(
                  child: Image.asset(AppAssets.test_badge,
                      width: ResponsiveValue<double>(context,
                          defaultValue: 100, valueWhen: [const Condition.smallerThan(name: TABLET, value: 80)]).value),
                ),
                AlignedMaterialButton(
                  child: Image.asset(AppAssets.test_badge,
                      width: ResponsiveValue<double>(context,
                          defaultValue: 100, valueWhen: [const Condition.smallerThan(name: TABLET, value: 80)]).value),
                ),
                AlignedMaterialButton(
                  child: Image.asset(AppAssets.test_badge,
                      width: ResponsiveValue<double>(context,
                          defaultValue: 100, valueWhen: [const Condition.smallerThan(name: TABLET, value: 80)]).value),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              '3. 결과를 확인해주세요',
            ),
            SizedBox(
              height: 30,
            ),
            AlignedMaterialButton(
              child: RepaintBoundary(
                  key: genKey,
                  child: Container(
                    child: Image.asset(
                      AppAssets.bannerPath + _selectedBanner.fileName,
                      width: 400,
                    ),
                    color: Colors.red,
                  )),
            ),
            SizedBox(
              height: 100,
            ),
            RoundedElevatedButton(onPressed: _onPressedSave, child: Text('Save')),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPressedSave() async {
    try {
      final RenderRepaintBoundary boundary = genKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();

      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();

      final content = base64Encode(pngBytes!.toList());
      final anchor = AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,$content")
        ..setAttribute("download", "splatbanner.png")
        ..click();
    } catch (ex) {
      //TODO: 오류처리하기
    }
  }

  Future<void> _onTapBanner() async {
    try {
      final bannerResult = await Navigator.pushNamed(context, RouteNames.banner_select_screen);
      if (bannerResult == null) return;

      setState(() {
        _selectedBanner = bannerResult as BannerModel;
      });
    } catch (ex) {
      //TODO: 오류처리하기
    }
  }
}
