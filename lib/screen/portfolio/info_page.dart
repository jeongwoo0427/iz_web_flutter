import 'package:flutter/material.dart';

import '../../widget/scaffold/constrained_layout.dart';
import '../../widget/subtitle_widget.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 80),
      width: double.infinity,
      decoration: BoxDecoration(color: colorScheme.background),
      child: ConstrainedLayout(
        child: Column(
          children: [
            SubtitleWidget(iconData: Icons.info,text: 'ABOUT ME',),
            SizedBox(
              height: 50,
            ),
            Wrap(
              spacing: 80,
              runSpacing: 10,
              children: [
                _getInfoItem(iconData: Icons.person, title: '이름', content: '김정우'),
                _getInfoItem(iconData: Icons.cake, title: '생년월일', content: '1998.04.27'),
                _getInfoItem(iconData: Icons.home, title: '주소', content: '서울특별시 마포구'),
                _getInfoItem(iconData: Icons.phone, title: '연락처', content: '010-7245-8521'),
                _getInfoItem(iconData: Icons.mail, title: '이메일', content: 'jwk9022648@gmail.com'),
                _getInfoItem(iconData: Icons.work, title: '직장', content: '(주)학지사'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _getInfoItem({required IconData iconData, required String title, required String content}) {
    return Container(
      height: 100,
      width: 270,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            size: 35,
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 8,
              ),
              Text(content, style: TextStyle(fontSize: 18)),
            ],
          )
        ],
      ),
    );
  }
}
