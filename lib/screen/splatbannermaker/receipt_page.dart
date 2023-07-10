import 'dart:convert';
import 'dart:developer';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:iz_web_flutter/app_router.dart';
import 'package:iz_web_flutter/constant/app_font_family.dart';
import 'package:iz_web_flutter/core/mixin/dialog_mixin.dart';
import 'package:iz_web_flutter/core/model/splatbannermaker/badge_model.dart';
import 'package:iz_web_flutter/core/model/splatbannermaker/banner_model.dart';
import 'package:iz_web_flutter/core/model/splatbannermaker/receipt_model.dart';
import 'package:iz_web_flutter/core/service/api/data/splatbannermaker_data.dart';
import 'package:iz_web_flutter/widget/input/rounded_textfield_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'dart:ui' as ui;

import '../../constant/app_assets.dart';
import '../../constant/app_constants.dart';
import '../../widget/button/AlignedMaterialButton.dart';
import '../../widget/button/rounded_elevated_button.dart';
import '../../widget/scaffold/constrained_layout.dart';

class ReceiptPage extends StatefulWidget {
  ReceiptPage({Key? key}) : super(key: key);

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> with DialogMixin {
  final GlobalKey genKey = GlobalKey();

  late BannerModel _selectedBanner;
  late BadgeModel _selectedBadge1;
  late BadgeModel _selectedBadge2;
  late BadgeModel _selectedBadge3;

  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _mottoController = TextEditingController();

  int _fontColor = 0;
  double _fontSizeRatio = 0.5;
  double _badgeSizeRatio = 0.5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedBanner = BannerModel(no: 13, name: 'name', fileName: 'tile013.png', rareLevel: 'rareLevel');
    _selectedBadge1 = BadgeModel(no: 288, name: 'name', fileName: 'tile288.png', rareLevel: 'rareLevel');
    _selectedBadge2 = BadgeModel(no: 288, name: 'name', fileName: 'tile288.png', rareLevel: 'rareLevel');
    _selectedBadge3 = BadgeModel(no: 288, name: 'name', fileName: 'tile288.png', rareLevel: 'rareLevel');
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return  Column(
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
            onTap: _onTapBanner,
            child: Image.asset(AppAssets.SPLAT_BANNER_PATH + _selectedBanner.fileName,
                width: ResponsiveValue<double>(context,
                    defaultValue: 600, valueWhen: [const Condition.smallerThan(name: TABLET, value: 400)]).value)),
        SizedBox(
          height: 100,
        ),
        Text(
          '2. 뱃지를 선택해 주세요.',
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
              child: Image.asset(AppAssets.SPLAT_BADGE_PATH + _selectedBadge1.fileName,
                  width: ResponsiveValue<double>(context,
                      defaultValue: 100, valueWhen: [const Condition.smallerThan(name: TABLET, value: 80)]).value),
            ),
            AlignedMaterialButton(
              onTap: _onTapBadge2,
              child: Image.asset(AppAssets.SPLAT_BADGE_PATH + _selectedBadge2.fileName,
                  width: ResponsiveValue<double>(context,
                      defaultValue: 100, valueWhen: [const Condition.smallerThan(name: TABLET, value: 80)]).value),
            ),
            AlignedMaterialButton(
              onTap: _onTapBadge3,
              child: Image.asset(AppAssets.SPLAT_BADGE_PATH + _selectedBadge3.fileName,
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
                  width: _fontColor == 0 ? 80 : 60,
                  height: _fontColor == 0 ? 80 : 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black,
                      border: Border.all(color: _fontColor == 0 ? colorScheme.primary : Colors.grey, width: 3)),
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
                  width: _fontColor == 1 ? 80 : 60,
                  height: _fontColor == 1 ? 80 : 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      border: Border.all(color: _fontColor == 1 ? colorScheme.primary : Colors.grey, width: 3)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 100,
        ),
        Text(
          '7. 각 요소별 크기를 정합니다.',
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('글자크기'),
            Expanded(
                child: Slider(
                  value: _fontSizeRatio,
                  onChanged: (value) {
                    setState(() {
                      _fontSizeRatio = value;
                    });
                  },
                  divisions: 10,
                  label: '글자크기',
                )),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('뱃지크기'),
            Expanded(
                child: Slider(
                  value: _badgeSizeRatio,
                  onChanged: (value) {
                    setState(() {
                      _badgeSizeRatio = value;
                    });
                  },
                  divisions: 10,
                  label: '뱃지크기',
                )),
          ],
        ),
        SizedBox(
          height: 100,
        ),
        Text(
          '8. 따란~',
        ),
        SizedBox(
          height: 30,
        ),
        _buildResult(),
        SizedBox(
          height: 100,
        ),
        Align(
          child: SizedBox(width: 200, child: RoundedElevatedButton(onPressed: _onPressedSave, child: Text('Save'))),
          alignment: Alignment.center,
        ),
        SizedBox(
          height: 100,
        ),
      ],);
  }

  Widget _buildResult() {
    return AlignedMaterialButton(
      child: RepaintBoundary(
          key: genKey,
          child: Container(
              child: Stack(
                children: [
                  Image.asset(
                    AppAssets.SPLAT_BANNER_PATH + _selectedBanner.fileName,
                    width: 400,
                  ),
                  Positioned(
                    right: 5,
                    bottom: 3,
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssets.SPLAT_BADGE_PATH + _selectedBadge1.fileName,
                          width: 32 + (_badgeSizeRatio * 10), //originalSize: 37
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Image.asset(
                          AppAssets.SPLAT_BADGE_PATH + _selectedBadge2.fileName,
                          width: 32 + (_badgeSizeRatio * 10), //originalSize: 37
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Image.asset(
                          AppAssets.SPLAT_BADGE_PATH + _selectedBadge3.fileName,
                          width: 32 + (_badgeSizeRatio * 10), //originalSize: 37
                        )
                      ],
                    ),
                  ),
                  Positioned.fill(
                      child: Center(
                    child: Text(
                      _nicknameController.text, //originalSize: 36
                      style: TextStyle(
                          fontSize: 26 + (_fontSizeRatio * 20),
                          fontWeight: FontWeight.w300,
                          color: _fontColor == 0 ? Colors.black : Colors.white,
                          fontFamily: AppFontFamily.splatoon2_k),
                    ),
                  )),
                  Positioned(
                      top: 5,
                      left: 8,
                      child: Text(
                        _mottoController.text, //originalSize: 15
                        style: TextStyle(
                            fontSize: 11.5 + (_fontSizeRatio * 7),
                            fontWeight: FontWeight.w600,
                            color: _fontColor == 0 ? Colors.black : Colors.white,
                            fontFamily: AppFontFamily.cookie_run),
                      )),
                  Positioned(
                      bottom: 5,
                      left: 13,
                      child: Text(
                        _tagController.text, //originalSize: 13
                        style: TextStyle(
                            fontSize: 9.5 + (_fontSizeRatio * 7),
                            fontWeight: FontWeight.w300,
                            color: _fontColor == 0 ? Colors.black : Colors.white,
                            fontFamily: AppFontFamily.cookie_run),
                      ))
                ],
              ),
              color: Colors.transparent)),
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

      ReceiptModel receiptModel = ReceiptModel(
          receiptNo: 0,
          bannerNo: _selectedBanner.no,
          badge1No: _selectedBadge1.no,
          badge2No: _selectedBadge2.no,
          badge3No: _selectedBadge3.no,
          nickname: _nicknameController.text,
          tag: _tagController.text,
          motto: _mottoController.text,
          fontColor: _fontColor,
          fontSizeRatio: _fontSizeRatio,
          badgeSizeRatio: _badgeSizeRatio);

      ReceiptModel? newReceiptModel = await SplatBannerMakerData().newReceipt(receiptModel);
      print(newReceiptModel?.receiptNo.toString());
    } catch (err) {
      handlingErrorDialog(context, err);
      //log(ex.toString(), stackTrace: StackTrace.current);
    }
  }

  Future<void> _onTapBanner() async {
    try {
      final bannerResult = await context.pushNamed(RouteNames.RN_banner_select_screen);
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
      final badgeResult = await context.pushNamed(RouteNames.RN_badge_select_screen);
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
      final badgeResult = await context.pushNamed(RouteNames.RN_badge_select_screen);
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
      final badgeResult = await context.pushNamed(RouteNames.RN_badge_select_screen);
      if (badgeResult == null) return;

      setState(() {
        _selectedBadge3 = badgeResult as BadgeModel;
      });
    } catch (ex) {
      //TODO: 오류처리하기
    }
  }
}
