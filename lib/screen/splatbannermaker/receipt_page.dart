import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iz_web_flutter/constant/app_font_family.dart';
import 'package:iz_web_flutter/core/model/splatbannermaker/badge_model.dart';
import 'package:iz_web_flutter/core/model/splatbannermaker/banner_model.dart';
import 'package:iz_web_flutter/widget/input/rounded_textfield_widget.dart';
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
  late BadgeModel _selectedBadge1;
  late BadgeModel _selectedBadge2;
  late BadgeModel _selectedBadge3;

  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _mottoController = TextEditingController();

  int _fontColor = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedBanner = BannerModel(no: 0, name: 'name', fileName: 'tile013.png', rareLevel: 'rareLevel');
    _selectedBadge1 = BadgeModel(no: 288, name: 'name', fileName: 'tile288.png', rareLevel: 'rareLevel');
    _selectedBadge2 = BadgeModel(no: 288, name: 'name', fileName: 'tile288.png', rareLevel: 'rareLevel');
    _selectedBadge3 = BadgeModel(no: 288, name: 'name', fileName: 'tile288.png', rareLevel: 'rareLevel');
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ConstrainedLayout(
      child: DefaultTextStyle(
        style: TextStyle(
          color: colorScheme.onBackground,
          fontWeight: FontWeight.w800,
          fontFamily: AppFontFamily.cookie_run,
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
              '2. 배찌를 선택해 주세요.',
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AlignedMaterialButton(
                  onTap: _onTapBadge1,
                  child: Image.asset(AppAssets.badgePath + _selectedBadge1.fileName,
                      width: ResponsiveValue<double>(context,
                          defaultValue: 100, valueWhen: [const Condition.smallerThan(name: TABLET, value: 80)]).value),
                ),
                AlignedMaterialButton(
                  onTap: _onTapBadge2,
                  child: Image.asset(AppAssets.badgePath + _selectedBadge2.fileName,
                      width: ResponsiveValue<double>(context,
                          defaultValue: 100, valueWhen: [const Condition.smallerThan(name: TABLET, value: 80)]).value),
                ),
                AlignedMaterialButton(
                  onTap: _onTapBadge3,
                  child: Image.asset(AppAssets.badgePath + _selectedBadge3.fileName,
                      width: ResponsiveValue<double>(context,
                          defaultValue: 100, valueWhen: [const Condition.smallerThan(name: TABLET, value: 80)]).value),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              '3. 닉네임을 입력해주세요.',
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: RoundedTextFieldWidget(
                      hint: 'ex) 겸사단',
                      controller: _nicknameController,
                      onChanged: (text) {
                        setState(() {});
                      },
                    )),
                Expanded(flex: 3, child: SizedBox())
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              '4. 태그번호를 입력해주세요.',
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: RoundedTextFieldWidget(
                      hint: 'ex) #2580',
                      controller: _tagController,
                      onChanged: (text) {
                        setState(() {});
                      },
                    )),
                Expanded(flex: 3, child: SizedBox())
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              '5. 좌우명을 입력해주세요.',
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: RoundedTextFieldWidget(
                      hint: 'ex) 밀크팀에 푹 빠진',
                      controller: _mottoController,
                      onChanged: (text) {
                        setState(() {});
                      },
                    )),
                Expanded(flex: 3, child: SizedBox())
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              '6. 글자 색상을 선택해주세요.',
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 90,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _fontColor = 0;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.decelerate,
                      width: _fontColor==0?80:60,
                      height:_fontColor==0?80:60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100), color: Colors.black, border: Border.all(color: _fontColor==0?colorScheme.primary:Colors.grey, width: 3)),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _fontColor = 1;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.decelerate,
                      width: _fontColor==1?80:60,
                      height: _fontColor==1?80:60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100), color: Colors.white, border: Border.all(color: _fontColor==1?colorScheme.primary:Colors.grey, width: 3)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              '7. 결과를 확인해주세요',
            ),
            SizedBox(
              height: 30,
            ),
            _buildResult(),
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

  Widget _buildResult() {
    return AlignedMaterialButton(
      child: RepaintBoundary(
          key: genKey,
          child: Container(
            child: Stack(
              children: [
                Image.asset(
                  AppAssets.bannerPath + _selectedBanner.fileName,
                  width: 400,
                ),
                Positioned(
                  right: 5,
                  bottom: 3,
                  child: Row(
                    children: [
                      Image.asset(
                        AppAssets.badgePath + _selectedBadge1.fileName,
                        width: 37,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Image.asset(
                        AppAssets.badgePath + _selectedBadge2.fileName,
                        width: 37,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Image.asset(
                        AppAssets.badgePath + _selectedBadge3.fileName,
                        width: 37,
                      )
                    ],
                  ),
                ),
                Positioned.fill(
                    child: Center(
                  child: Text(
                    _nicknameController.text,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w300, color: _fontColor==0? Colors.black:Colors.white, fontFamily: AppFontFamily.splatoon2_k),
                  ),
                )),
                Positioned(
                    top: 5,
                    left: 8,
                    child: Text(
                      _mottoController.text,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: _fontColor==0? Colors.black:Colors.white, fontFamily: AppFontFamily.cookie_run),
                    )),
                Positioned(
                    bottom: 5,
                    left: 13,
                    child: Text(
                      _tagController.text,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w300, color: _fontColor==0? Colors.black:Colors.white, fontFamily: AppFontFamily.cookie_run),
                    ))
              ],
            ),
            color: Colors.red,
          )),
    );
  }

  Future<void> _onPressedSave() async {
    try {
      final RenderRepaintBoundary boundary = genKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 5);

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

  Future<void> _onTapBadge1() async {
    try {
      final badgeResult = await Navigator.pushNamed(context, RouteNames.badge_select_screen);
      if (badgeResult == null) return;

      setState(() {
        _selectedBadge1 = badgeResult as BadgeModel;
      });
    } catch (ex) {
      //TODO: 오류처리하기
    }
  }

  Future<void> _onTapBadge2() async {
    try {
      final badgeResult = await Navigator.pushNamed(context, RouteNames.badge_select_screen);
      if (badgeResult == null) return;

      setState(() {
        _selectedBadge2 = badgeResult as BadgeModel;
      });
    } catch (ex) {
      //TODO: 오류처리하기
    }
  }

  Future<void> _onTapBadge3() async {
    try {
      final badgeResult = await Navigator.pushNamed(context, RouteNames.badge_select_screen);
      if (badgeResult == null) return;

      setState(() {
        _selectedBadge3 = badgeResult as BadgeModel;
      });
    } catch (ex) {
      //TODO: 오류처리하기
    }
  }
}