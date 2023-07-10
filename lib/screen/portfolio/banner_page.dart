import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:iz_web_flutter/constant/app_assets.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../widget/button/rounded_elevated_button.dart';
import '../../widget/scaffold/constrained_layout.dart';

class BannerPage extends StatelessWidget {
  const BannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      //height: ResponsiveWrapper.of(context).isSmallerThan(TABLET) ? 500 : 800,
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AppAssets.PORTFOIO_BANNER), fit: BoxFit.cover)),
      child: ConstrainedLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                FadeInUp(
                  from: 10,
                  duration: Duration(milliseconds: 800),
                  delay: Duration(milliseconds: 500),
                  child: Text(
                    '`김정우`',
                    style: TextStyle(
                        fontSize: ResponsiveValue<double>(context,
                            defaultValue: 43, valueWhen: [const Condition.smallerThan(name: TABLET, value: 34)]).value,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FadeInUp(
                  from: 10,
                  duration: Duration(milliseconds: 800),
                  delay: Duration(milliseconds: 1000),
                  child: Text(
                    '플러터 개발자 소개페이지',
                    style: TextStyle(
                        fontSize: ResponsiveValue<double>(context,
                            defaultValue: 43, valueWhen: [const Condition.smallerThan(name: TABLET, value: 34)]).value,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.orange,
              width: 50,
              height: 5,
            ),
            FadeInUp(
              from: 10,
              duration: Duration(milliseconds: 800),
              delay: Duration(milliseconds: 1500),
              child: Text(
                '안녕하세요 플러터로 개발된 웹사이트로 방문해주신 것을\n진심으로 환영합니다!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize:
                        ResponsiveValue<double>(context, defaultValue: 23, valueWhen: [const Condition.smallerThan(name: TABLET, value: 18)])
                            .value,
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.bold),
              ),
            ),
            ElasticIn(
                delay: Duration(milliseconds: 2000),
                child: RoundedElevatedButton(onPressed: () {}, child: Text('더 알아보기')))
          ],
        ),
      ),
    );
  }
}
