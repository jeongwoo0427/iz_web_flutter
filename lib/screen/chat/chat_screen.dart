import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iz_web_flutter/constant/app_constants.dart';
import 'package:iz_web_flutter/core/cache/preference_helper.dart';
import 'package:iz_web_flutter/core/mixin/dialog_mixin.dart';
import 'package:iz_web_flutter/core/model/chat/message_model.dart';
import 'package:iz_web_flutter/core/model/chat/user_model.dart';
import 'package:iz_web_flutter/core/state/socket_state.dart';
import 'package:iz_web_flutter/widget/dialog/card_button_dialog.dart';
import 'package:iz_web_flutter/widget/input/rounded_textfield_widget.dart';
import 'package:iz_web_flutter/widget/navigation_widget.dart';
import 'package:iz_web_flutter/widget/scaffold/web_responsive_scaffold.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with DialogMixin {
  final IO.Socket _socket = SocketState().socket;
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocus = FocusNode();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final String roomCode = 'code1234';
  final _uuid = Uuid();
  final List<MessageModel> _messages = [];

  UserModel userInfo =
      UserModel(userId: 'unknown_user', userName: 'Unknown User');

  @override
  void initState() {
    //print('initState');
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    await Future.delayed(Duration(milliseconds: 1));

    String? userID = await PreferenceHelper().getUserID();
    String? userName = await PreferenceHelper().getUserName();

    if(userID == null){
      await PreferenceHelper().setUserID(_uuid.v4());
    }

    if (userName == null) {
      final result = await _showUserSettingDialog();
      if (result != true) return;
    }

    userID = await PreferenceHelper().getUserID();
    userName = await PreferenceHelper().getUserName();
    userInfo =
        UserModel(userId: userID!, userName: userName!);

    _initSocket();
  }

  Future<bool> _showUserSettingDialog() async {
    final TextEditingController controller = TextEditingController();

    final result = await showDialog(
        context: context,
        builder: (context) => CardButtonDialog(
              width: 400,
              child: Column(
                children: [
                  Text(
                    '프로필 설정',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Text('닉네임')),
                        Expanded(
                            flex: 6,
                            child: RoundedTextFieldWidget(
                              controller: controller,
                              maxLength: 10,
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              onTapConfirm: () {
                Navigator.pop(context, true);
              },
              confirmText: '저장',
            ));

    if (result != true) return false;

    await PreferenceHelper().setUserName(controller.text);
    return true;
  }

  Future<void> _initSocket() async {
    _socket.emit('joinRoom', [
      {"roomCode": roomCode, "userInfo": userInfo.toMap()}
    ]);

    _socket.on('roomJoined', (data) {
      if (!this.mounted) return;

      final String socketId = data['socketId'];
      final UserModel user = UserModel.fromMap(data['userInfo']);
      if (_socket.id == socketId) {
        final MessageModel messageModel = MessageModel(
            uuid: _uuid.v4(),
            roomCode: roomCode,
            type: ChatMessageTypes.ALRT,
            content: '${user.userName}님이 등장하셨습니다.',
            userInfo: userInfo);
        _socket.emit('sendMessage', [messageModel.toMap()]);
      }
    });

    _socket.on('messageReceived', (data) {
      if (!this.mounted) return;

      MessageModel message = MessageModel.fromMap(data);
      print(data);
      setState(() {
        _messages.insert(0, message);
      });
    });
    _socket.on('fromServer', (_) => print(_));
    _socket.on('error', (data) => print(data));
    _socket.on('hey', (data) => print('hey ${data}'));
    _socket.onDisconnect((_) => print('disconnect'));
  }

  @override
  void dispose() {
    _socket.emit('quitRoom');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return WebResponsiveScaffold(
      navigationWidget: NavigationWidget(
        menuCode: MenuCodes.CHAT,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,
            height: (screenSize.height - 90) * 0.8,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 5)
              ],
            ),
            child: Column(
              children: [
                Expanded(
                    child: ListView.separated(
                        reverse: true,
                        key: _listKey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        itemCount: _messages.length,
                        separatorBuilder: (_, __) => SizedBox(
                              height: ResponsiveValue<double>(context,
                                  defaultValue: 18,
                                  valueWhen: [
                                    Condition.smallerThan(
                                        name: TABLET, value: 10)
                                  ]).value,
                            ),
                        itemBuilder: (context, index) {
                          return buildItem(context, index);
                        })),
                Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colorScheme.onSurface.withOpacity(0.1)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RawKeyboardListener(
                              autofocus: true,
                              focusNode: FocusNode(),
                              onKey: (event) {
                                // print(event);
                                if (event
                                    .isKeyPressed(LogicalKeyboardKey.enter)) {
                                  // just keyDown
                                  _sendMessage();
                                }
                              },
                              child: TextFormField(
                                focusNode: _messageFocus,
                                textInputAction: TextInputAction.none,
                                //이걸 해줘야 엔터 입력에도 포커스가 나가지 않음
                                controller: _messageController,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 3),
                                    hintText: "여기에 메시지를 입력하세요."),
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: _sendMessage,
                              child:
                                  SizedBox(width: 60, child: Icon(Icons.send)))
                        ],
                      )),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    final Size screenSize = MediaQuery.of(context).size;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final MessageModel message = _messages[index];

    if (_messages[index].type == ChatMessageTypes.ALRT) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(message.content),
          )
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: message.userInfo.userId == userInfo.userId? MainAxisAlignment.end: MainAxisAlignment.start,
      children: [
        Column(
            crossAxisAlignment:message.userInfo.userId == userInfo.userId?  CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
          if(message.userInfo.userId != userInfo.userId)Text(message.userInfo.userName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),
          SizedBox(height: 5,),
          Container(
            constraints: BoxConstraints(
              minWidth: 40,
              maxWidth: ResponsiveValue<double>(context,
                  defaultValue: 700,
                  valueWhen: [
                    Condition.smallerThan(
                        name: TABLET, value: screenSize.width * 0.7)
                  ]).value!,
            ),
            child: Column(
              children: [
                Text(
                  message.content,
                  style: TextStyle(fontWeight: FontWeight.w300),
                )
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: message.userInfo.userId == userInfo.userId?colorScheme.primary.withOpacity(0.5):colorScheme.onSurface.withOpacity(0.1)),
          ),
        ]),
      ],
    );
  }

  void _sendMessage() {
    if (_messageController.text.length == 0) return;

    final MessageModel messageModel = MessageModel(
        uuid: _uuid.v4(),
        roomCode: roomCode,
        type: ChatMessageTypes.MSG,
        content: _messageController.text,
        userInfo: userInfo);

    _socket.emit('sendMessage', [messageModel.toMap()]);
    setState(() {
      _messageController.text = '';
    });
    _messageFocus.requestFocus();
  }
}
