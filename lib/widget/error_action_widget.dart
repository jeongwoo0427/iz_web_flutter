import 'package:flutter/material.dart';

class ErrorActionWidget extends StatelessWidget {

  final String message;
  final String actionMessage;
  final Function onRetry;

  ErrorActionWidget({this.message = '오류가 발생했습니다.',this.actionMessage = '다시시도', required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        MaterialButton(
          onPressed: () {
            this.onRetry();
          },
          child: Text(actionMessage),
        )
      ],
    );
  }
}
