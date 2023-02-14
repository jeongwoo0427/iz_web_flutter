import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/error/http_failure.dart';

mixin DialogMixin {
  Future<void> showAlertDialog(BuildContext context, {required String title, required String content,String positiveText = '네'}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(positiveText),
              )
            ],
          );
        });
  }

  Future<dynamic> showTextDialog(BuildContext context,
      {required String title, required String hintText, String initialText = '', int? maxLength}) async {
    TextEditingController textController = TextEditingController(text: initialText);

    return await showDialog(
        context: context,
        builder: (context) {
          Size screenSize = MediaQuery.of(context).size;
          return Dialog(
            child: Container(
              height: 200,
              width: 100,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    TextField(
                      maxLength: maxLength,
                      controller: textController,
                      decoration: InputDecoration(hintText: hintText),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        MaterialButton(
                          onPressed: () {
                            if (textController.text.trim() == '') {
                              showAlertDialog(context, title: '주의', content: '최소 1글자 이상입니다.');
                              return;
                            }
                            Navigator.pop(context, textController.text);
                          },
                          child: Text('완료'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<dynamic> showConfirmDialog(
      {required BuildContext context,
      required String title,
      required String content,
      String negativeText = '아니요',
      String positiveText = '예'}) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(negativeText),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(positiveText),
              )
            ],
          );
        });
  }


  Future<dynamic> handlingErrorDialog(BuildContext context, err) async{
    if(err is HttpFailure){
      HttpFailure failure = err;
      log('error)${failure.message}',stackTrace: StackTrace.current,error: err);

      ///401은 오류메시지만 표시
      ///419는 오류메시지 표시 및 선택적 재로그인

      if(failure.code == 401){
        await showAlertDialog(context, title: '인증오류', content: failure.message);
      }else if(failure.code == 419){
        //Provider.of<AuthState>(context,listen: false).signOut();
        //await showLoginDialog(context,customMessage: failure.message);
      }else{
        await showAlertDialog(context, title: '오류', content: failure.message,positiveText: '확인');
      }
    }else if(err is String){
      log('error)${err}',stackTrace: StackTrace.current,error: err);
      await showAlertDialog(context, title: '오류', content: err.toString(),positiveText: '확인');
    }else {
      log('error) unknown error has occurred',stackTrace: StackTrace.current,error: err);
      await showAlertDialog(context, title: '오류', content: '오류가 발생했습니다.',positiveText: '확인');
    }
  }

}
