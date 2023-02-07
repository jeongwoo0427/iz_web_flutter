import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
            _BannerSector(onTapBanner: _onTapBanner,),
            _BadgeSector(),
            _ResultSector(genKey: genKey),
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
    try{
      final RenderRepaintBoundary boundary = genKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();

      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();

      final content = base64Encode(pngBytes!.toList());
      final anchor = AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,$content")
        ..setAttribute("download", "splatbanner.png")
        ..click();
    }catch(ex){

      //TODO: 오류처리하기
    }

  }

  Future<void> _onTapBanner() async{
    try{
      final bannerIndexResult = Navigator.pushNamed(context, RouteNames.banner_select_screen);
    }catch(ex){
      //TODO: 오류처리하기
    }
  }
}

class _BannerSector extends StatelessWidget {

  final  onTapBanner;

  const _BannerSector({Key? key,required this.onTapBanner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          onTap: onTapBanner,
          child: Image.asset(AppAssets.test_banner,
              width: ResponsiveValue<double>(context,
                  defaultValue: 600, valueWhen: [const Condition.smallerThan(name: TABLET, value: 400)]).value)),
      SizedBox(
        height: 100,
      ),
    ],);
  }
}


class _BadgeSector extends StatelessWidget {
  const _BadgeSector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],);
  }
}

class _ResultSector extends StatelessWidget {
  final GlobalKey genKey;

  const _ResultSector({Key? key,required this.genKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  AppAssets.test_banner,
                  width: 400,
                ),
                color: Colors.red,
              )),
        ),
        SizedBox(
          height: 100,
        ),
      ],);
  }
}






