import 'package:flutter/material.dart';
import 'package:iz_web_flutter/core/model/chat/user_model.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../constant/app_constants.dart';
import '../../core/model/chat/message_model.dart';

class ChatListView extends StatelessWidget {
  final UserModel userInfo;
  final List<MessageModel> messages;

  const ChatListView(
      {super.key, required this.userInfo, required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        reverse: true,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        itemCount: messages.length,
        separatorBuilder: (_, __) => SizedBox(
              height: ResponsiveValue<double>(context,
                  defaultValue: 18,
                  valueWhen: [
                    Condition.smallerThan(name: TABLET, value: 10)
                  ]).value,
            ),
        itemBuilder: (context, index) {
          return buildItem(context, index);
        });
  }

  Widget buildItem(BuildContext context, int index) {
    final Size screenSize = MediaQuery.of(context).size;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final MessageModel message = messages[index];

    if (messages[index].type == ChatMessageTypes.ALRT) {
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
      mainAxisAlignment: message.userId == userInfo.userId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Column(
            crossAxisAlignment: message.userId == userInfo.userId
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              if (message.userId != userInfo.userId)
                Text(
                  message.userName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
              SizedBox(
                height: 5,
              ),
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
                    color: message.userId == userInfo.userId
                        ? colorScheme.primary.withOpacity(0.5)
                        : colorScheme.onSurface.withOpacity(0.1)),
              ),
            ]),
      ],
    );
  }
}
