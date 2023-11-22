import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iz_web_flutter/core/service/socket/chat_socket_service.dart';
import 'package:uuid/uuid.dart';

import '../../core/cache/preference_helper.dart';
import '../../core/model/chat/user_model.dart';
import '../../core/state/chat_room_user_state.dart';
import '../../widget/dialog/card_button_dialog.dart';
import '../../widget/input/rounded_textfield_widget.dart';

class UserSettingDialog extends ConsumerStatefulWidget {
  const UserSettingDialog({super.key});

  @override
  _UserSettingDialogState createState() => _UserSettingDialogState();
}

class _UserSettingDialogState extends ConsumerState<UserSettingDialog> {
  late final TextEditingController _controller;
  final _uuid = Uuid();
  late String _userId;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final UserModel? user = ref.read(chatRoomUserState);
    _userId = user?.userId ?? _uuid.v4();
    _controller = TextEditingController(text: user?.userName ?? '');
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
                      //await PreferenceHelper().setUserID(userID);

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
      onTapConfirm: () async {
        final UserModel user =  UserModel(userId: _userId, userName: _controller.text);
        await ref.read(chatRoomUserState.notifier).updateUser(
            user:user);
        //await PreferenceHelper().setUserName(_controller.text);
        ChatSocketService().socket.emit('updateUserInfo',[user.toMap()]);
        Navigator.pop(context, true);
      },
      confirmText: '저장',
    );
  }
}
