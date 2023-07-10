import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SubtitleWidget extends StatelessWidget {
  final IconData iconData;
  final String text;

  const SubtitleWidget({Key? key, required this.iconData, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 15,left: 3,right: 8),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: colorScheme.onBackground.withOpacity(0.6),width: 2)
              )
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: ResponsiveValue<double>(context, defaultValue: 43, valueWhen: [const Condition.smallerThan(name: TABLET, value: 34)])
                    .value,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:
                      ResponsiveValue<double>(context, defaultValue: 43, valueWhen: [const Condition.smallerThan(name: TABLET, value: 34)])
                          .value,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
