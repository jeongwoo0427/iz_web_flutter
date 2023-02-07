import 'package:flutter/material.dart';

class RoundedElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final BorderRadius borderRadius;
  final EdgeInsets? padding;
  final Color? foregroundColor;
  final Color? backgroundColor;

  RoundedElevatedButton({required this.onPressed, BorderRadius? borderRadius, this.padding, required this.child,this.foregroundColor, this.backgroundColor})
      : this.borderRadius = borderRadius ?? BorderRadius.circular(32);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: this.borderRadius),primary: backgroundColor??colorScheme.primary),
      onPressed: onPressed,
      child: DefaultTextStyle(
        style: TextStyle(fontSize: 16, color: foregroundColor??colorScheme.onPrimary),
        child: Padding(padding: padding ?? EdgeInsets.symmetric(horizontal: 25, vertical: 18), child: child),
      ),
    );
  }
}
