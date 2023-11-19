import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iz_web_flutter/constant/app_constants.dart';
import 'package:iz_web_flutter/core/cache/preference_helper.dart';
import 'package:iz_web_flutter/core/mixin/dialog_mixin.dart';
import 'package:iz_web_flutter/core/mixin/future_mixin.dart';
import 'package:iz_web_flutter/core/model/chat/message_model.dart';
import 'package:iz_web_flutter/core/model/chat/user_model.dart';
import 'package:iz_web_flutter/core/service/api/data/chat_message_data.dart';
import 'package:iz_web_flutter/core/state/chat_room_users_state.dart';
import 'package:iz_web_flutter/core/state/socket_state.dart';
import 'package:iz_web_flutter/screen/chat/chat_input_field.dart';
import 'package:iz_web_flutter/screen/chat/chat_listview.dart';
import 'package:iz_web_flutter/screen/chat/chat_status_bar.dart';
import 'package:iz_web_flutter/screen/chat/user_setting_dialog.dart';
import 'package:iz_web_flutter/widget/dialog/card_button_dialog.dart';
import 'package:iz_web_flutter/widget/drawer/chat_room_users_drawer.dart';
import 'package:iz_web_flutter/widget/input/rounded_textfield_widget.dart';
import 'package:iz_web_flutter/widget/navigation_widget.dart';
import 'package:iz_web_flutter/widget/scaffold/web_responsive_scaffold.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> with DialogMixin, FutureMixin {
  final IO.Socket _socket = SocketState().socket;
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocus = FocusNode();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final String roomCode = 'code1234';
  final _uuid = Uuid();
  List<MessageModel> _messages = [];
  late Future<bool> isMessageFutureFetched;

  UserModel userInfo =
  UserModel(userId: 'unknown_user', userName: 'Unknown User');

  @override
  void initState() {
    //print('initState');
    super.initState();

    isMessageFutureFetched = _fetchData();
  }

  Future<bool> _fetchData() async {
    try {
      await _fetchUser();
      await Future.delayed(Duration(milliseconds: 200));

      List<MessageModel> messages =
      await ChatMessageData().getMessages(roomCode: roomCode);

      _messages = messages;

      _initSocket();
      return true;
    } catch (err, stack) {
      handlingErrorDialog(context, err, stack);
      throw err;
    }
  }

  Future<void> _fetchUser() async {
    await Future.delayed(Duration(milliseconds: 1));

    String? userID = await PreferenceHelper().getUserID();
    if (userID == null) {
      userID = _uuid.v4();
      await PreferenceHelper().setUserID(userID);
    }

    String? userName = await PreferenceHelper().getUserName();
    if (userName == null) {
      final result = await _showUserSettingDialog(userId: userID);
      if (result != true) return;
    }

    userID = await PreferenceHelper().getUserID();
    userName = await PreferenceHelper().getUserName();

    userInfo = UserModel(userId: userID!, userName: userName!);
  }

  Future<bool> _showUserSettingDialog({required String userId}) async {
    final result = await showDialog(
        context: context,
        builder: (context) =>
            UserSettingDialog(
              userId: userId,
            ));

    if (result != true) return false;

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
      //print(data);
      if (_socket.id == socketId) {
        final MessageModel messageModel = MessageModel(
            uuid: _uuid.v4(),
            roomCode: roomCode,
            type: ChatMessageTypes.ALRT,
            content: '${user.userName}님이 등장하셨습니다.',
            userId: userInfo.userId,
            userName: userInfo.userName);
        _socket.emit('sendMessage', [messageModel.toMap()]);
      }
    });

    _socket.on('messageReceived', (data) {
      if (!this.mounted) return;

      MessageModel message = MessageModel.fromMap(data);
      //print(data);
      setState(() {
        _messages.insert(0, message);
      });
    });

    _socket.on('updateRoomUsers', (data){
      print(data);
       if (!this.mounted) return;
       List<UserModel> users =[];
       for(int i = 0; i<data.length; i++){
         users.add(UserModel.fromMap(data[i]));
       }
       ref.read(chatRoomUsersState.notifier).fetchUsers(users: users);
    });

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
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final ColorScheme colorScheme = Theme
        .of(context)
        .colorScheme;
    final SizedBox responsiveSizedBox = SizedBox(
      height: ResponsiveValue<double>(context,
          defaultValue: 30,
          valueWhen: [const Condition.smallerThan(name: TABLET, value: 20)])
          .value,
    );
    return WebResponsiveScaffold(
      navigationWidget: NavigationWidget(
        menuCode: MenuCodes.CHAT,
      ),
      endDrawer: ChatRoomUsersDrawer(),
      body: Column(
        children: [
          responsiveSizedBox,
          ChatStatusBar(),
          responsiveSizedBox,
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
                    child: FutureBuilder<bool>(
                      future: isMessageFutureFetched,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return buildLoader();
                        }
                        if (snapshot.hasError) {
                          return buildError();
                        } else if (snapshot.hasData) {
                          return buildSuccess(_messages);
                        }
                        return buildNoData();
                      },
                    )),
                ChatInputField(
                    messageController: _messageController,
                    messageFocus: _messageFocus,
                    sendMessage: _sendMessage),
              ],
            ),
          ),
          responsiveSizedBox,
          responsiveSizedBox,
          responsiveSizedBox,
        ],
      ),
    );
  }

  @override
  Widget buildSuccess(data) {
    return ChatListView(
      userInfo: userInfo,
      messages: data,
    );
  }

  void _sendMessage() {
    if (_messageController.text.length == 0) return;

    final MessageModel messageModel = MessageModel(
        uuid: _uuid.v4(),
        roomCode: roomCode,
        type: ChatMessageTypes.MSG,
        content: _messageController.text,
        userId: userInfo.userId,
        userName: userInfo.userName);

    _socket.emit('sendMessage', [messageModel.toMap()]);
    setState(() {
      _messageController.text = '';
    });
    _messageFocus.requestFocus();
  }
}
