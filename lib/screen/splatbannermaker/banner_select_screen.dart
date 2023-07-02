import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iz_web_flutter/constant/app_assets.dart';
import 'package:iz_web_flutter/constant/app_constants.dart';
import 'package:iz_web_flutter/core/implement/future_status.dart';
import 'package:iz_web_flutter/widget/button/AlignedMaterialButton.dart';
import 'package:iz_web_flutter/widget/error_action_widget.dart';
import 'package:iz_web_flutter/widget/scaffold/constrained_layout.dart';
import 'package:iz_web_flutter/widget/scaffold/web_responsive_scaffold.dart';

import '../../core/model/splatbannermaker/banner_model.dart';

class BannerSelectScreen extends StatefulWidget {
  BannerSelectScreen({Key? key}) : super(key: key);

  @override
  State<BannerSelectScreen> createState() => _BannerSelectScreenState();
}

class _BannerSelectScreenState extends State<BannerSelectScreen> {
  late Future<List<BannerModel>> bannersFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bannersFuture = fetch();
  }

  @override
  Widget build(BuildContext context) {
    return WebResponsiveScaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<BannerModel>>(
        future: bannersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return buildLoader();
          }
          if (snapshot.hasError) {
            return buildError();
          }
          if (snapshot.hasData) {
            return buildSuccess(snapshot.data!);
          }
          return buildNoData();
        },
      ),
    );
  }

  @override
  Widget buildLoader() {
    return const Center(
      child: Padding(
          padding:EdgeInsets.symmetric(vertical: 100),
          child: CircularProgressIndicator()),
    );
  }

  @override
  Widget buildError() {
    return Center(
      child: ErrorActionWidget(
        onRetry: () {
          setState(() {
            bannersFuture = fetch();
          });
        },
      ),
    );
  }

  @override
  Widget buildNoData() {
    return Center(
      child: ErrorActionWidget(
        message: '데이터가 없습니다.',
        onRetry: () {
          setState(() {
            bannersFuture = fetch();
          });
        },
      ),
    );
  }

  @override
  Widget buildSuccess(List<BannerModel> banners) {
    return ConstrainedLayout(
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: globalHorizonPadding15, vertical: 20),
        itemCount: banners.length,
        separatorBuilder: (context, _) {
          return SizedBox(
            height: 15,
          );
        },
        itemBuilder: (context, index) {
          return AlignedMaterialButton(
            child: Image.asset(AppAssets.bannerPath + banners[index].fileName,width: 600,),
            onTap: () {
              _onTapBannerItem(banners[index]);
            },
          );
        },
      ),
    );
  }

  Future<List<BannerModel>> fetch() async {
    try {
      await Future.delayed(Duration(milliseconds: 300));
      String rawJson = await DefaultAssetBundle.of(context).loadString("asset/json/banners.json");

      Map bannerMap = jsonDecode(rawJson);

      List<BannerModel> banners = [];
      for (int i = 0; i < bannerMap['banners'].length; i++) {
        banners.add(BannerModel.fromMap(bannerMap['banners'][i]));
      }

      return banners;
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  void _onTapBannerItem(BannerModel item) {
    print(item.no.toString());
    Navigator.pop(context, item);
  }
}
