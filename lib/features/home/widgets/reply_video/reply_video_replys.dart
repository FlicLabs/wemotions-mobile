import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icons.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/widgets/reply_video/reply_video_replys_post.dart';

class VideoReplySheet extends StatelessWidget {
  final bool? isFromVideoPlayer;
  final String? dynamicLink;
  const VideoReplySheet({
    Key? key,
    this.isFromVideoPlayer,
    this.dynamicLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final notification = Provider.of<NotificationProvider>(context);
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 0, bottom: 40, right: 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Theme.of(context).canvasColor,
      ),
      child: SizedBox(
        height: cs.height(context)/2.6,
        width: cs.width(context),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                width10,
                Expanded(
                  child: Center(
                      child: Text(
                        'Video Replies',
                        style: AppTextStyle.bodyLarge,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      AppAsset.icClose,
                      fit: BoxFit.scaleDown,
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ),
              ],
            ),
            height10,
            Divider(color:Constants.tabBarGrey,),
            height10,
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ReplyVideoReplyPost(),
            ),

          ],
        ),
      ),
    );
  }
}
