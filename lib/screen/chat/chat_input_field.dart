import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatInputField extends StatelessWidget {

  final TextEditingController messageController;
  final FocusNode messageFocus ;
  final void Function() sendMessage;

  ChatInputField({super.key,required this.messageController, required this.messageFocus,required this.sendMessage});



  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
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
                      sendMessage();
                    }
                  },
                  child: TextFormField(
                    focusNode: messageFocus,
                    textInputAction: TextInputAction.none,
                    //이걸 해줘야 엔터 입력에도 포커스가 나가지 않음
                    controller: messageController,
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
                  onTap: sendMessage,
                  child:
                  SizedBox(width: 60, child: Icon(Icons.send)))
            ],
          )),
    );
  }
}
