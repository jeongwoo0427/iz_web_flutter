import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../core/cache/preference_helper.dart';
import '../../widget/dialog/card_button_dialog.dart';
import '../../widget/input/rounded_textfield_widget.dart';

class UserSettingDialog extends StatefulWidget {
  final String userId;
  final String? userName;
  const UserSettingDialog({super.key, required this.userId, this.userName});

  @override
  State<UserSettingDialog> createState() => _UserSettingDialogState();
}

class _UserSettingDialogState extends State<UserSettingDialog> {

  late final TextEditingController _controller;
  final _uuid = Uuid();
  late String _userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController(text: widget.userName);
    _userId = widget.userId;
  }

  @override
  Widget build(BuildContext context) {
    return CardButtonDialog(
      width: 500,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Text(
              '프로필 설정',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(flex: 1, child: Text('UID')),
                Expanded(
                    flex: 6,
                    child: Text(
                      _userId,
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6)),
                    )),
                IconButton(
                    onPressed: () async {
                      String userID = _uuid.v4();
                      await PreferenceHelper().setUserID(userID);

                      setState(() {
                        _userId = userID;
                      });
                    },
                    icon: Icon(Icons.refresh))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(flex: 1, child: Text('닉네임')),
                Expanded(
                    flex: 6,
                    child: RoundedTextFieldWidget(
                      controller: _controller,
                      maxLength: 10,
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      onTapConfirm: () async{

        await PreferenceHelper().setUserName(_controller.text);
        Navigator.pop(context, true);
      },
      confirmText: '저장',
    );
  }
}
