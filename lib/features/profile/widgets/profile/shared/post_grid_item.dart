import 'package:socialverse/export.dart';

class PostGridItem extends StatelessWidget {
  const PostGridItem({
    Key? key,
    required this.onTap,
    required this.imageUrl,
    required this.createdAt,
    required this.viewCount, required this.voteCount,
  }) : super(key: key);
  final VoidCallback onTap;
  final String imageUrl;
  final int createdAt;
  final int viewCount;
  final int voteCount;

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
            child: Stack(

              children: [CustomNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: 500,
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.transparent,
                        ],
                        stops: [
                          0.0,
                          1.0
                        ],
                        end: FractionalOffset.topCenter,
                    begin: FractionalOffset.bottomCenter,
                        )
                ),
              )
              ],
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
                    Image.asset(
                      AppAsset.icon,
                      color: Colors.white,
                      width: 16,
                      height: 16,
                    ),
                    width2,
                    Text(
                      '${voteCount}',
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
          Positioned(
            bottom: 5,
            right: 5,
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
