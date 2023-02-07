import 'package:flutter/material.dart';

class OutlinedRoundButton extends StatefulWidget {

  final EdgeInsets? padding;
  final Widget? child;
  final Color? color;
  final GestureTapCallback? onPressed;

  OutlinedRoundButton(
      {this.child,
        this.padding,
      this.color,
      this.onPressed});

  @override
  _OutlinedRoundButtonState createState() =>
      _OutlinedRoundButtonState();
}

class _OutlinedRoundButtonState extends State<OutlinedRoundButton> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return MaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: widget.padding?? EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      minWidth: 0,
      height: 0,
      child: DefaultTextStyle(
        style: TextStyle(color: widget.color??themeData.colorScheme.primary),
        child: widget.child??Container(),
      ),
      onPressed: widget.onPressed,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: widget.color??themeData.colorScheme.primary, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(50)),
    );
  }
}
