import 'package:socialverse/export.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String action;
  final String content;
  final Function() tap;
  final Function()? cancelTap;

  const CustomAlertDialog(
      {Key? key,
      required this.title,
      required this.action,
      required this.content,
      required this.tap,
      this.cancelTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _showAndroidDialog(
      context: context,
      tap: tap,
      content: content,
      title: title,
      action: action,
      cancelTap: cancelTap,
    );
  }

  AlertDialog _showAndroidDialog({
    required BuildContext context,
    required String content,
    required String title,
    required String action,
    required Function()? tap,
    Function()? cancelTap,
  }) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Theme.of(context).canvasColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      content: Text(
        content,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontSize: 15, color: Colors.grey),
      ),
      actions: [
        SizedBox(
          width: cs().width(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(
                color: Colors.grey,
              ),
              height10,
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: cancelTap ??
                          () {
                            Navigator.of(context).pop();
                          },
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 15, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 15,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: tap,
                      child: Center(
                        child: Text(
                          action,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 15,
                                    color: Theme.of(context).hintColor,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              height10,
            ],
          ),
        )
      ],
    );
  }
}
