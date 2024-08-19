import 'package:socialverse/export.dart';

class PostGridItem extends StatelessWidget {
  const PostGridItem({
    Key? key,
    required this.onTap,
    required this.imageUrl,
    required this.createdAt,
    required this.viewCount,
  }) : super(key: key);
  final VoidCallback onTap;
  final String imageUrl;
  final int createdAt;
  final int viewCount;

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
            bottom: 5,
            left: 5,
            child: Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 16,
                    ),
                    width2,
                    Text(
                      '${viewCount}',
                      style: AppTextStyle.bodySmall.copyWith(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
