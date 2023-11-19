import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iz_web_flutter/core/model/chat/user_model.dart';
import 'package:iz_web_flutter/core/state/chat_room_users_state.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ChatRoomUsersDrawer extends ConsumerWidget {
  const ChatRoomUsersDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final ChatRoomUsersNotifier usersNotifier =
        ref.read(chatRoomUsersState.notifier);
    final List<UserModel> users = ref.watch(chatRoomUsersState);
    final double responsiveRatio = ResponsiveValue(context,
            defaultValue: 1.0,
            valueWhen: [
              const Condition.smallerThan(name: TABLET, value: 0.8)
            ]).value ??
        1;
    return Drawer(
        child: Column(
            children: [
      Container(
        width: double.infinity,
        height: 100 * responsiveRatio,
        child: Center(
            child: Text(
          '접속중인 사용자 : ${users.length}명',
          style: TextStyle(
              fontSize: 18 * responsiveRatio, fontWeight: FontWeight.w800),
        )),
        decoration: BoxDecoration(
            color: colorScheme.primary,
            border: Border.all(color: Colors.transparent, width: 0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0.0, 5.0),
                  blurRadius: 3,
                  color: Colors.black12)
            ]),
      ),
      SizedBox(
        height: 20 * responsiveRatio,
      ),
      Text('온라인'),
      SizedBox(
        height: 10 * responsiveRatio,
      ),
      Expanded(
        child: ListView.separated(
            padding: EdgeInsets.symmetric(
                horizontal: 15 * responsiveRatio,
                vertical: 10 * responsiveRatio),
            itemCount: users.length,
            separatorBuilder: (_, __) => SizedBox(
                  height: 15 * responsiveRatio,
                ),
            itemBuilder: (context, index) {
              return Material(
                borderRadius: BorderRadius.circular(10 * responsiveRatio),
                elevation: 4,
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10 * responsiveRatio,
                        vertical: 10 * responsiveRatio),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          users[index].userId,
                          style: TextStyle(
                              fontSize: 14 * responsiveRatio,
                              color: colorScheme.onSurface.withOpacity(0.6)),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          users[index].userName,
                          style: TextStyle(
                              fontSize: 17 * responsiveRatio,
                              fontWeight: FontWeight.w800,
                              color: colorScheme.onSurface),
                        ),
                    ],)),
              );
            }),
      )
    ]));
  }
}
