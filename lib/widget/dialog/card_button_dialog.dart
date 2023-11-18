import 'package:flutter/material.dart';

class CardButtonDialog extends StatelessWidget {
  final Widget? child;
  final double width;
  final double maxHeight;
  final double borderRadiusCirular;
  final String confirmText;
  final VoidCallback? onTapConfirm;

  const CardButtonDialog({Key? key, this.child, this.width = 200,this.maxHeight=double.infinity, this.borderRadiusCirular = 30, this.confirmText = '', this.onTapConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusCirular), side: BorderSide(color: colorScheme.primary, width: 3)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadiusCirular),
        child: Container(
            width: width,
            constraints: BoxConstraints(minHeight: 160,maxHeight: maxHeight),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              // border: Border.all(
              //   color: colorScheme.primary,
              //   width: 3,
              // ),
              //borderRadius: BorderRadius.circular(borderRadiusCirular),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: DefaultTextStyle(style: TextStyle(fontWeight: FontWeight.w700, color: colorScheme.onSurface), child: child ?? SizedBox())),
                Material(
                  color: colorScheme.primary,
                  child: InkWell(
                    onTap: onTapConfirm,
                    child: Container(
                      child: Center(
                          child: Text(
                        confirmText,
                        style: TextStyle(fontWeight: FontWeight.w500, color: colorScheme.onPrimary,fontSize: 16),
                      )),
                      width: double.infinity,
                      height: 50,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
