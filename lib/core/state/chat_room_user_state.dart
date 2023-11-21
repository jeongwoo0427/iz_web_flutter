import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iz_web_flutter/core/model/chat/user_model.dart';
import 'package:uuid/uuid.dart';

import '../cache/preference_helper.dart';

final chatRoomUserState =
    StateNotifierProvider<ChatRoomUserNotifier, UserModel?>(
        (ref) => ChatRoomUserNotifier());

class ChatRoomUserNotifier extends StateNotifier<UserModel?> {
  ChatRoomUserNotifier() : super(null);

  Future<void> fetchUser() async {
    String? userID = await PreferenceHelper().getUserID();
    String? userName = await PreferenceHelper().getUserName();

    print(userID??'none'+' '+(userName??'none'));
    if (userID == null || userName == null) {
      state = null;
      return;
    }

    state = UserModel(userId: userID, userName: userName);
  }

  Future<void> updateUser({required UserModel user}) async{
    await PreferenceHelper().setUserID(user.userId);
    await PreferenceHelper().setUserName(user.userName);

    state = UserModel(userId: user.userId, userName: user.userName);
  }
}
