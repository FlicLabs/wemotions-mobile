import 'package:socialverse/export.dart';

class SubversePostGridItem extends StatelessWidget {
  const SubversePostGridItem({
    Key? key,
    required this.onTap,
    required this.imageUrl,
    required this.createdAt,
    required this.viewCount,
    required this.username,
    required this.pictureUrl,
  }) : super(key: key);

  final VoidCallback onTap;
  final String imageUrl;
  final int createdAt;
  final int viewCount;
  final String username;
  final String pictureUrl;

  @override
  Widget build(BuildContext context) {
    DateTime formatTimestamp(int timestamp) {
      var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return date;
    }

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Center(
            child: CustomNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: 500,
            ),
          ),
            Positioned(
            bottom: 10, 
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: CustomCircularAvatar(
                    borderColor: Theme.of(context).hintColor,
                    height: 24, 
                    width: 24, 
                    imageUrl: pictureUrl,
                  ),
                ),
                Text(
                  username,
                  textAlign: TextAlign.center, 
                  style: AppTextStyle.bodySmall.copyWith(
                    fontSize: 10, 
                    fontWeight: FontWeight.w400, 
                    color:Colors.black
                    // Colors.white, 
                  ),
                ),
              ],
            ),
          ),

          // Positioned(
          //   bottom: 5,
          //   left: 5,
          //   child: Row(
          //     children: [
          //       Row(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(
          //             Icons.play_arrow,
          //             color: Colors.white,
          //             size: 16,
          //           ),
          //           width2,
          //           Text(
          //             '${viewCount}',
          //             style: AppTextStyle.bodySmall.copyWith(
          //               fontSize: 13,
          //               color: Colors.white,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
