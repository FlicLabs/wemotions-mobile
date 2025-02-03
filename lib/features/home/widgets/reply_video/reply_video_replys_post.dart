import 'package:socialverse/export.dart';

class ReplyVideoReplyPost extends StatelessWidget {
  const ReplyVideoReplyPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: cs.width(context)/1.2,
            child: Row(
              children: [
                CustomCircularAvatar(
                  imageUrl: "imageUrl",
                  height: 40,
                  width: 40,
                ),
                width15,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "username",
                        style: Theme.of(context).textTheme.headlineMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      height5,
                      Text(
                        'relier type',
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    ],
                  ),
                ),
                width15,
                Text('1h',style: Theme.of(context).textTheme.headlineSmall,)
              ],
            ),
          ),
          height10,
          Container(
            height: cs.width(context)*0.32,
            width: cs.width(context)/1.1,
            color:Colors.red,
            child: Text('Video Player'),
          ),
          height5,
          Text("View 40 reply",style: Theme.of(context).textTheme.headlineSmall,),
        ],
      ),
    );
  }
}
