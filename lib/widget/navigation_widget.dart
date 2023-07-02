import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iz_web_flutter/app_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'scaffold/constrained_layout.dart';

class NavigationWidget extends StatefulWidget {
  final bool showBackColor;

  const NavigationWidget({Key? key, this.showBackColor = false})
      : super(key: key);

  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  @override
  Widget build(BuildContext context) {
    //print(ResponsiveWrapper.of(context).scaledWidth);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.decelerate,
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
            color:
                widget.showBackColor ? colorScheme.primary : Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: widget.showBackColor
                      ? Colors.black.withOpacity(0.2)
                      : Colors.transparent,
                  offset: Offset(0, 2),
                  blurRadius: 5)
            ]),
        padding: ResponsiveValue<EdgeInsets>(context,
            defaultValue: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            valueWhen: [
              const Condition.smallerThan(
                  name: TABLET, value: EdgeInsets.symmetric(horizontal: 10))
            ]).value,
        child: ConstrainedLayout(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'IZ web',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: widget.showBackColor
                        ? colorScheme.onBackground
                        : Colors.white.withOpacity(0.9)),
              ),
              // ResponsiveWrapper.of(context).isSmallerThan(TABLET)
              //     ? Text('넴플메이커')
              //     :
              Row(
                      children: [
                        GestureDetector(
                          child: Text('넴플메이커'),
                          onTap: () {
                            context.goNamed(RouteNames.splatbannermaker_screen);
                          },
                        ),
                        SizedBox(width: 20,),
                        GestureDetector(
                          child: Text('test'),
                          onTap: () {
                            context.goNamed(RouteNames.test_screen);
                          },
                        )
                      ],
                    )
            ],
          ),
        ));
  }
}
