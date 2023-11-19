import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iz_web_flutter/core/model/chat/user_model.dart';
import 'package:iz_web_flutter/core/state/chat_room_users_state.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ChatStatusBar extends ConsumerWidget {
  const ChatStatusBar({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final ChatRoomUsersNotifier usersNotifier = ref.read(chatRoomUsersState.notifier);
    final List<UserModel> users = ref.watch(chatRoomUsersState);

    final double responsiveRatio = ResponsiveValue<double>(context,
            defaultValue: 1,
            valueWhen: [
              const Condition.smallerThan(name: TABLET, value: 0.7)
            ]).value ??
        1;
    return Container(
        width: double.infinity,
        height: 70 * responsiveRatio,
        padding: EdgeInsets.symmetric(horizontal: 20*responsiveRatio),
        decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: colorScheme.onSurface.withOpacity(0.3))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text('기본채팅방'),

            Row(
              children: [

                Material(
                    type: MaterialType.transparency,
                    clipBehavior: Clip.none,
                    child: Stack(
                      children: [
                        IconButton(
                            iconSize: 30 * responsiveRatio,
                            onPressed: () {},
                            icon: Icon(
                              Icons.settings,
                            ))
                      ],
                    )),
                Material(
                    type: MaterialType.transparency,
                    clipBehavior: Clip.none,
                    child: Stack(
                      children: [
                        IconButton(
                            iconSize: 30 * responsiveRatio,
                            onPressed: () {},
                            icon: Icon(
                              Icons.people,
                            ))
                      ],
                    )),
                Text('${users.length}명')
              ],
            )
          ],
        ));
  }
}
