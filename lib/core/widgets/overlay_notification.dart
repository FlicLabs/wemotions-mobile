import 'package:flutter/material.dart';
import 'package:socialverse/export.dart';

class OverlayNotification extends StatefulWidget {
  final String? title;
  final String? body;
  final String? username;
  final String? imageUrl;
  final int? chatId;
  final NotificationType type;
  final String? chatType;
  final VoidCallback onDismiss;

  const OverlayNotification({
    Key? key,
    required this.title,
    required this.body,
    required this.username,
    required this.imageUrl,
    required this.chatId,
    required this.type,
    required this.chatType,
    required this.onDismiss,
  }) : super(key: key);

  @override
  _OverlayNotificationState createState() => _OverlayNotificationState();
}

class _OverlayNotificationState extends State<OverlayNotification>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _position;
  late final Animation<double> _fadeOut;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _position = Tween<Offset>(
      begin: const Offset(0.0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeOut = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).size.height * 0.85,
      ),
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.topCenter,
          child: Dismissible(
            key: const Key('overlay_notification'),
            direction: DismissDirection.up,
            onDismissed: (_) {
              widget.onDismiss();
            },
            child: FadeTransition(
              opacity: _fadeOut,
              child: SlideTransition(
                position: _position,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: widget.type == NotificationType.push ? 65 : 45,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  decoration: BoxDecoration(
                    color: widget.type == NotificationType.local
                        ? Constants.fillGrey
                        : Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(
                        widget.type == NotificationType.push ? 10 : 5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        if (widget.type == NotificationType.local) ...[
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.title ?? '',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                        ],
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: widget.onDismiss,
                        ),
                      ],
                    ),
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
