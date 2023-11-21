import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iz_web_flutter/core/model/chat/user_model.dart';
import 'package:iz_web_flutter/core/state/chat_room_users_state.dart';
import 'package:responsive_framework/responsive_framework.dart';

class NavigationMenuDrawer extends ConsumerWidget {
  const NavigationMenuDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

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

    ]));
  }
}
