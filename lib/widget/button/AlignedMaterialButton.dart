import 'package:flutter/material.dart';

class AlignedMaterialButton extends StatelessWidget {

  final VoidCallback? onTap;
  final Widget child;

  const AlignedMaterialButton({Key? key, required this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Material(
        elevation: 10,
        child: Stack(
          children: [
            child,
            Positioned.fill(child: Material(color: Colors.transparent,child: InkWell(onTap:onTap))
            )
          ],),
      ),
    );
  }
}
