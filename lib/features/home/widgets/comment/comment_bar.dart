import 'package:socialverse/export.dart';

class CommentBar extends StatelessWidget {
  const CommentBar({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    return Consumer<CommentProvider>(
      builder: (_, __, ___) {
        final notification = Provider.of<NotificationProvider>(context);
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              height: isKeyboardShowing
                  ? cs().height(context) * 0.08
                  : cs().height(context) * 0.1,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: .0,
                    spreadRadius: 0.05,
                  )
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(1),
                  topRight: Radius.circular(1),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 10,
                  top: 14,
                  left: 20,
                  right: 10,
                ),
                child: TextFormField(
                  controller: __.comment,
                  style: Theme.of(context).textTheme.displayMedium,
                  focusNode: __.focusNode,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Add comment...",
                    hintStyle: TextStyle(
                      fontFamily: 'sofia',
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (__.comment.text.isNotEmpty) {
                          __.addComment(post_id: id, body: __.comment.text);
                        } else {
                          notification.show(
                            type: NotificationType.local,
                            title: 'Enter a comment!',
                          );
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).indicatorColor,
                        size: 24,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
