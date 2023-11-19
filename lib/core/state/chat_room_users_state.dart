import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iz_web_flutter/core/model/chat/user_model.dart';

final chatRoomUsersState =
    StateNotifierProvider<ChatRoomUsersNotifier, List<UserModel>>(
        (ref) => ChatRoomUsersNotifier());

class ChatRoomUsersNotifier extends StateNotifier<List<UserModel>> {
  ChatRoomUsersNotifier() : super([]);

  void fetchUsers({required List<UserModel> users}) {
    state = users;
  }
}
