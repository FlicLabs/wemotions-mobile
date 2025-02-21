import 'package:socialverse/export.dart';

class PostUploadIndicator extends StatelessWidget {
  const PostUploadIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (_, __, ___) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                if (__.is_uploading_post == true) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: cs.width(context)/1.4,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CircularPercentIndicator(
                            radius: 30,
                            lineWidth: 5,
                            percent: __.upload_percentage_value / 100,
                            progressColor: Theme.of(context).hintColor,
                            animation: true,
                            animationDuration: 0,
                            center: Text(
                              '${__.upload_percentage_value}' + '%',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          width15,
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your video is uploading',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                      fontSize: 14, color: Colors.white),
                                ),
                                height5,
                                Text(
                                  'Please wait a little longer',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],

              ],
            ),
          ),
        );
      },
    );
  }
}
