import 'package:flutter/material.dart';

class ChatTextBar extends StatelessWidget {
  final bool replying;
  final String replyingTo;
  final List<Widget> actions;
  final TextEditingController textController;
  final Color replyWidgetColor;
  final Color replyIconColor;
  final Color replyCloseColor;
  final Color messageBarColor;
  final TextStyle messageBarHintStyle;
  final TextStyle textFieldTextStyle;
  final Color sendButtonColor;
  final void Function(String)? onTextChanged;
  final void Function(String)? onSend;
  final void Function()? onTap;
  final void Function()? onTapCloseReply;

  /// [ChatTextBar] constructor

  ChatTextBar({
    required this.textController,
    required this.onTap,
    this.replying = false,
    this.replyingTo = "",
    this.actions = const [],
    this.replyWidgetColor = const Color(0xffF4F4F5),
    this.replyIconColor = Colors.blue,
    this.replyCloseColor = Colors.black12,
    this.messageBarColor = const Color(0xffF4F4F5),
    this.sendButtonColor = Colors.blue,
    this.messageBarHintStyle = const TextStyle(fontSize: 16),
    this.textFieldTextStyle = const TextStyle(color: Colors.black),
    this.onTextChanged,
    this.onSend,
    this.onTapCloseReply,
  });

  /// [ChatTextBar] builder method
  ///
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ValueListenableBuilder(
        valueListenable: textController,
        builder: (_, __, ___) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                replying
                    ? Container(
                        color: replyWidgetColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.reply,
                              color: replyIconColor,
                              size: 24,
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'Re : ' + replyingTo,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: onTapCloseReply,
                              child: Icon(
                                Icons.close,
                                color: replyCloseColor,
                                size: 24,
                              ),
                            ),
                          ],
                        ))
                    : Container(),
                replying
                    ? Container(
                        height: 1,
                        color: Colors.grey.shade300,
                      )
                    : Container(),
                Container(
                  color: messageBarColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Row(
                    children: <Widget>[
                      ...actions,
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: textController,
                            keyboardType: TextInputType.multiline,
                            textCapitalization: TextCapitalization.sentences,
                            minLines: 1,
                            // textInputAction: __.text.trim().isEmpty
                            //     ? TextInputAction.done
                            //     : TextInputAction.newline,
                            maxLines: 3, // Allows for unlimited lines
                            onChanged: (value) {},
                            // onSubmitted: (value) {
                            //   if (value == '') {
                            //     FocusScope.of(context)
                            //         .requestFocus(new FocusNode());
                            //   }
                            // },
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 13),
                            decoration: InputDecoration(
                              hintMaxLines: 1,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 10,
                              ),
                              hintStyle: messageBarHintStyle,
                              fillColor: Theme.of(context).canvasColor,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 0.2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 0.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (!__.text.trim().isEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: InkWell(
                            child: Icon(
                              Icons.send,
                              color: sendButtonColor,
                              size: 24,
                            ),
                            onTap: onTap,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
