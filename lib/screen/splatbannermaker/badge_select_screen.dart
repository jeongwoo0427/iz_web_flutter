import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iz_web_flutter/constant/app_assets.dart';
import 'package:iz_web_flutter/constant/app_constants.dart';
import 'package:iz_web_flutter/core/implement/future_status.dart';
import 'package:iz_web_flutter/widget/button/AlignedMaterialButton.dart';
import 'package:iz_web_flutter/widget/error_action_widget.dart';
import 'package:iz_web_flutter/widget/scaffold/constrained_layout.dart';
import 'package:iz_web_flutter/widget/scaffold/web_responsive_scaffold.dart';

import '../../core/model/splatbannermaker/badge_model.dart';

class BadgeSelectScreen extends StatefulWidget {
  BadgeSelectScreen({Key? key}) : super(key: key);

  @override
  State<BadgeSelectScreen> createState() => _BadgeSelectScreenState();
}

class _BadgeSelectScreenState extends State<BadgeSelectScreen> {
  late Future<List<BadgeModel>> badgesFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    badgesFuture = fetch();
  }

  @override
  Widget build(BuildContext context) {
    return WebResponsiveScaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<BadgeModel>>(
        future: badgesFuture,
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
            badgesFuture = fetch();
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
            badgesFuture = fetch();
          });
        },
      ),
    );
  }

  @override
  Widget buildSuccess(List<BadgeModel> badges) {
    return ConstrainedLayout(
        child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: globalHorizonPadding25,vertical: 25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100, childAspectRatio: 1, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemCount: badges.length,
      itemBuilder: (context, index) {
         return AlignedMaterialButton(
          child: Image.asset(AppAssets.badgePath + badges[index].fileName,width: 80,),
          onTap: () {
            _onTapBadgeItem(badges[index]);
          },
        );;
      },
    ));
  }

  Future<List<BadgeModel>> fetch() async {
    try {
      await Future.delayed(Duration(milliseconds: 600));
      String rawJson = await DefaultAssetBundle.of(context).loadString("asset/json/badges.json");

      Map bannerMap = jsonDecode(rawJson);

      List<BadgeModel> badges = [];
      for (int i = 0; i < bannerMap['badges'].length; i++) {
        badges.add(BadgeModel.fromMap(bannerMap['badges'][i]));
      }

      return badges;
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  void _onTapBadgeItem(BadgeModel item) {
    print(item.fileName);
    Navigator.pop(context, item);
  }
}
