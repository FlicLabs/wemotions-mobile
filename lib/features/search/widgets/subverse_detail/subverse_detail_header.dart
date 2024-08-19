import 'package:socialverse/export.dart';

class SubverseDetailHeader extends StatelessWidget {
  const SubverseDetailHeader({
    Key? key,
    required this.category_photo,
    required this.category_name,
    required this.category_desc,
    required this.category_count,
  }) : super(key: key);

  final String category_photo;
  final String category_name;
  final String category_desc;
  final int category_count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomCircularAvatar(
            imageUrl: category_photo,
            height: 80,
            width: 80,
          ),
          width10,
          SizedBox(
            width: cs().width(context) * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (category_desc.isNotEmpty)
                  Text(
                    category_desc,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16),
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                // Text(
                //   category_name,
                //   style: Theme.of(context).textTheme.bodyLarge,
                //   textAlign: TextAlign.start,
                // ),
                Text(
                  category_count.toString() + ' Videos',
                  style: AppTextStyle.bodySmall.copyWith(
                    fontSize: 14,
                    color: Theme.of(context).focusColor,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
