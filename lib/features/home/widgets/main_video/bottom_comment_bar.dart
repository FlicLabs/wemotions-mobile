import 'package:socialverse/export.dart';

class BottomCommentBar extends StatelessWidget {
  const BottomCommentBar({
    Key? key,
    required this.isKeyboardShowing,
  }) : super(key: key);

  final bool isKeyboardShowing;

  @override
  Widget build(BuildContext context) {
    final comment = Provider.of<CommentProvider>(context);
    final notification = Provider.of<NotificationProvider>(context);
    return Consumer<VideoProvider>(
      builder: (_, __, ___) {
        return Positioned(
          bottom: 0,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              width: cs().width(context),
              height: isKeyboardShowing
                  ? cs().height(context) * 0.08
                  : cs().height(context) * 0.1,
              color: Colors.grey.shade900,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  bottom: 10,
                  top: 10,
                  right: 10,
                ),
                child: TextFormField(
                  controller: comment.comment,
                  focusNode: comment.focusNode,
                  style: TextStyle(
                    fontFamily: 'sofia',
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "Add comment...",
                    hintStyle: TextStyle(
                      fontFamily: 'sofia',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        if (comment.comment.text.isNotEmpty) {
                          comment.addComment(
                            post_id: __.posts[__.index].id,
                            body: comment.comment.text,
                          );
                          comment.focusNode.unfocus();
                          notification.show(
                            type: NotificationType.local,
                            title: 'Comment added!',
                          );
                        } else {
                          notification.show(
                            type: NotificationType.local,
                            title: 'Enter a comment!',
                          );
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
