
import 'package:socialverse/export.dart';

class CreateSheetItem extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final String asset;
  const CreateSheetItem({
    Key? key,
    required this.onTap,
    required this.label,
    required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).disabledColor,
            radius: 22,
            child: SvgPicture.asset(
              asset,
              color: Theme.of(context).focusColor,
              height: 18,
            ),
          ),
          width10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 15, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
