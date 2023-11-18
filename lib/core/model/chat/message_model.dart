import 'package:iz_web_flutter/core/model/chat/user_model.dart';

class MessageModel {
  static const String CN_uuid = 'uuid';
  static const String CN_roomCode = 'roomCode';
  static const String CN_content = 'content';
  static const String CN_userInfo = 'userInfo';

  final String uuid;
  final String roomCode;
  final String content;
  final UserModel userInfo;

  MessageModel(
      {required this.uuid, required this.roomCode, required this.content, required this.userInfo});

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
        uuid: map[CN_uuid] ?? '',
        roomCode: map[CN_roomCode]??'',
        content: map[CN_content] ?? 'unknown_content',
        userInfo: UserModel.fromMap(map[CN_userInfo]));
  }

  Map<String,dynamic> toMap() {
    Map<String,dynamic> map = {};
    map[CN_uuid] = this.uuid;
    map[CN_roomCode] = this.roomCode;
    map[CN_content] = this.content;
    map[CN_userInfo] = this.userInfo.toMap();
    return map;
  }
}
