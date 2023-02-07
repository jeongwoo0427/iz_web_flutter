import 'package:flutter/material.dart';

class ConstrainedLayout extends StatelessWidget {
  final double maxWidth;
  final Widget child;
  const ConstrainedLayout({Key? key,this.maxWidth = 1000,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.center,child: ConstrainedBox(constraints: BoxConstraints(maxWidth: maxWidth),child:child ,),);
  }
}
