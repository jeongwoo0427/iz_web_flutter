import 'package:flutter/material.dart';

class RoundedTextFieldWidget extends StatelessWidget {
  final String title;
  final String? hint;
  final String? label;
  final String? counterText;
  final String? errorText;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final bool? obsecureText;
  final TextInputType? keyboardType;
  final funValidator;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final BorderRadius? borderRadius;
  final EdgeInsets? contentPadding;
  final BoxConstraints? constraints;

  const RoundedTextFieldWidget({
    this.title ='',
    this.hint = '',
    this.counterText,
    this.errorText,
    this.label,
    this.maxLength ,
    this.minLines,
    this.maxLines,
    this.obsecureText,
    this.keyboardType,
    this.funValidator,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.borderRadius,
    this.contentPadding,
    this.constraints
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(this.title!='')
        Text(this.title,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
        if(this.title!='')
        SizedBox(height: 5,),

        TextFormField(
          focusNode: focusNode,
          maxLength: this.maxLength,
          controller: controller,
          validator: funValidator,
          minLines: minLines,
          maxLines: maxLines??1,
          keyboardType: keyboardType,
          obscureText: obsecureText??false,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            labelText: label,
            counterText: counterText,
            errorText: errorText,
            hintStyle: themeData.inputDecorationTheme.hintStyle,
            constraints: constraints,
            suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            contentPadding: this.contentPadding??EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius??BorderRadius.circular(10),
                borderSide: BorderSide(color: themeData.colorScheme.onBackground.withOpacity(0.4))
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius??BorderRadius.circular(10),
                borderSide: BorderSide(color: themeData.colorScheme.primary)
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: borderRadius??BorderRadius.circular(10),
                borderSide: BorderSide(color: themeData.colorScheme.error)
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: borderRadius??BorderRadius.circular(10),
                borderSide: BorderSide(color: themeData.colorScheme.onBackground)
            ),
          ),
        )
      ],
    );
  }
}
