import 'package:iz_web_flutter/core/model/chat/user_model.dart';

class MessageModel {
  static const String CN_uuid = 'uuid';
  static const String CN_roomCode = 'roomCode';
  static const String CN_type = 'type';
  static const String CN_content = 'content';
  static const String CN_userId = 'userId';
  static const String CN_userName = 'userName';

  final String uuid;
  final String roomCode;
  final String type;
  final String content;
  final String userId;
  final String userName;

  MessageModel(
      {required this.uuid, required this.roomCode,required this.type, required this.content, required this.userId, required this.userName});

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
        uuid: map[CN_uuid] ?? '',
        roomCode: map[CN_roomCode]??'',
        type: map[CN_type]??'',
        content: map[CN_content] ?? 'unknown_content',
        userId: map[CN_userId] ?? '',
        userName: map[CN_userName] ??''
    );
  }

  Map<String,dynamic> toMap() {
    Map<String,dynamic> map = {};
    map[CN_uuid] = this.uuid;
    map[CN_roomCode] = this.roomCode;
    map[CN_type] = this.type;
    map[CN_content] = this.content;
    map[CN_userId] = this.userId;
    map[CN_userName] = this.userName;

    return map;
  }
}
