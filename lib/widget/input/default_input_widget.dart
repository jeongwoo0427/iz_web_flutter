import 'package:flutter/material.dart';

class DefaultInputWidget extends StatelessWidget {
  String? labelText;
  String? hintText;
  int? maxLength;
  FormFieldValidator<String>? validator;
  ValueChanged<String>? onChanged;
  TextEditingController? controller;

  DefaultInputWidget({this.labelText,this.maxLength, this.hintText, this.onChanged, this.validator,this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
