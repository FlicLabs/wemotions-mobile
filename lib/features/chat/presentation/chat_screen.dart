import 'package:socialverse/export.dart';
import 'package:socialverse/features/chat/widgets/date_chip.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat';
  const ChatScreen({super.key});

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ChatScreen(),
    );
  }

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    scrollToLastMessage();
  }

  void scrollToLastMessage() {
    final chat = Provider.of<ChatProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (chat.controller.hasClients) {
        chat.controller.jumpTo(chat.controller.position.maxScrollExtent);
        chat.scrolledToBottom = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final subverse = Provider.of<SearchProvider>(context);
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    final double bottomPadding = isKeyboardShowing ? 5 : 40;
    // final double bottomPadding = isKeyboardShowing ? 5 : 100;
    final chat = Provider.of<ChatProvider>(context);
    const double threshold = 150.0;

    return Scaffold(
      appBar: AppBar(
        //leading: shrink,
        //leadingWidth: 0,
        leadingWidth: 20,
        centerTitle: false,
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              GroupChatDetailScreen.routeName,
              arguments: GroupChatDetailScreenArgs(
                username: 'Vible Community',
                imageUrl: subverse.subverse_info.imageUrl,
                members: chat.members,
              ),
            );
          },
          child: Container(
            child: Row(
              children: [
                CustomCircularAvatar(
                  imageUrl: subverse.subverse_info.imageUrl,
                  height: 35,
                  width: 35,
                ),
                width10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vible Community',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        chat.loading
                            ? 'tap here for group info'
                            : chat.formatUsernames(chat.members),
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(
          //     right: 20.0,
          //     top: 10,
          //     bottom: 10,
          //   ),
          //   child: GestureDetector(
          //     onTap: () async {
          //       await HapticFeedback.mediumImpact();
          //     },
          //     child: Icon(
          //       UniconsLine.share,
          //       color: Theme.of(context).indicatorColor,
          //     ),
          //   ),
          // )
        ],
      ),
      body: Consumer<ChatProvider>(
        builder: (_, __, ___) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          double currentScroll = notification.metrics.pixels;

                          // bool isScrollingUp =
                          //     __.lastScrollPosition > currentScroll;
                          // __.lastScrollPosition = currentScroll;

                          // if (isScrollingUp) {
                          //   __.isScrollingUp = true;
                          // } else {
                          //   __.isScrollingUp = false;
                          // }

                          // if (notification is ScrollUpdateNotification) {
                          //   if (notification.scrollDelta! < 0 &&
                          //       isKeyboardShowing) {
                          //     FocusScope.of(context).unfocus();
                          //   }
                          // }

                          // if (notification is ScrollUpdateNotification) {
                          //   if (notification.scrollDelta! < -5) {
                          //     __.isScrollingUp = true;
                          //   } else {
                          //     __.isScrollingUp = false;
                          //   }
                          // }

                          // if (notification is ScrollUpdateNotification) {
                          //   __.lastScrollPosition = currentScroll;
                          //   log('Last Position: ${__.lastScrollPosition}');
                          // }

                          if (currentScroll <=
                              notification.metrics.minScrollExtent +
                                  threshold) {
                            if (!chat.isFetchingOlderMessages) {
                              chat.page++;
                              chat.fetchOlderMessages();
                            }
                          }
                          return true;
                        },
                        child: ListView.builder(
                          controller: __.controller,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: __.messages.length,
                          padding: EdgeInsets.only(bottom: bottomPadding + 80),
                          itemBuilder: (context, index) {
                            final message = __.messages[index];
                            bool isCurrentUser =
                                message.sender.username == prefs_username;
                            final chatItem = ChatItem(
                              isCurrentUser: isCurrentUser,
                              message: message,
                            );
                            if (index == 0 ||
                                _isNewDay(chat.messages[index - 1].sentAt,
                                    message.sentAt)) {
                              return Column(
                                children: [
                                  DateChip(date: _formatDate(message.sentAt)),
                                  chatItem,
                                ],
                              );
                            }
                            return chatItem;
                            // return ChatItem(
                            //   isCurrentUser: isCurrentUser,
                            //   message: message,
                            // );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                if (__.isScrollingUp) ...[
                  Positioned(
                    right: 0,
                    bottom: isKeyboardShowing
                        ? cs().height(context) * 0.115
                        : cs().height(context) * 0.155,
                    child: Container(
                      height: 40,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  //bottom: isKeyboardShowing ? 0 : cs().height(context) * 0.115,
                  child: Container(
                    color: Theme.of(context).hoverColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ChatTextBar(
                          textController: __.message,
                          messageBarColor: Theme.of(context).hoverColor,
                          sendButtonColor: Theme.of(context).hintColor,
                          onTap: () async {
                            await __.sendMessage();
                            if (__.controller.hasClients &&
                                __.controller.offset <
                                    __.controller.position.maxScrollExtent) {
                              await __.controller.animateTo(
                                __.controller.position.maxScrollExtent,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            }
                          },
                        ),
                        isKeyboardShowing
                            ? height5
                            : Platform.isIOS
                                ? height40
                                // ? height10
                                : height5,
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  bool _isNewDay(String previousDate, String currentDate) {
    // Convert strings to DateTime and compare dates
    DateTime prevDate = DateTime.parse(previousDate);
    DateTime currDate = DateTime.parse(currentDate);
    return prevDate.day != currDate.day ||
        prevDate.month != currDate.month ||
        prevDate.year != currDate.year;
  }

  DateTime _formatDate(String dateString) {
    return DateTime.parse(dateString);
  }
}
