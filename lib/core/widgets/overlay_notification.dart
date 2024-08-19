import 'package:socialverse/export.dart';

class OverlayNotification extends StatefulWidget {
  final String? title;
  final String? body;
  final String? username;
  final String? imageUrl;
  final int? chat_id;
  final NotificationType type;
  final String? chatType;
  final Function onDismiss;

  const OverlayNotification({
    Key? key,
    required this.title,
    required this.body,
    required this.username,
    required this.imageUrl,
    required this.chat_id,
    required this.type,
    required this.chatType,
    required this.onDismiss,
  }) : super(key: key);

  @override
  _OverlayNotificationState createState() => _OverlayNotificationState();
}

class _OverlayNotificationState extends State<OverlayNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> position;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    position = Tween<Offset>(begin: Offset(0.0, -4.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: cs().height(context) * 0.85,
      ),
      child: Material(
        // elevation: 2,
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.topCenter,
          child: Dismissible(
            key: Key('funky_notification'),
            direction: DismissDirection.up,
            onDismissed: (direction) {
              widget.onDismiss();
            },
            child: SlideTransition(
              position: position,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: widget.type == NotificationType.push ? 65 : 45,
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                decoration: ShapeDecoration(
                  color: widget.type == NotificationType.local
                      ? Constants.fillGrey
                      : Theme.of(context).canvasColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      widget.type == NotificationType.push ? 10 : 5,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          if (widget.type == NotificationType.push) ...[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      CustomCircularAvatar(
                                        imageUrl: widget.imageUrl,
                                        height: 38,
                                        width: 38,
                                      ),
                                      width10,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            widget.title ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(fontSize: 15),
                                          ),
                                          if (widget.chatType ==
                                              'groupChat') ...[
                                            Text(
                                              '${widget.username}${': '}${widget.body ?? ''}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                Navigator.pushNamed(
                                  context,
                                  ChatScreen.routeName,
                                );
                              },
                              child: Text(
                                'reply',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: Theme.of(context).hintColor),
                              ),
                            ),
                          ],
                          if (widget.type == NotificationType.local) ...[
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.title ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 13,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
