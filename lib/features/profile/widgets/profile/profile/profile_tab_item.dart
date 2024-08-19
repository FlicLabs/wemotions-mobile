import 'package:socialverse/export.dart';

class ProfileTabItem extends StatelessWidget {
  const ProfileTabItem({
    Key? key,
    required this.label,
    required this.index,
  }) : super(key: key);

  final String label;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (_, __, ___) {
        return InkWell(
          onTap: () {
            __.onTabChanged(index);
            if (index == 1) {
              __.getUserLikedPosts();
            }
          },
          child: Text(
            label,
            style: AppTextStyle.bodySmall.copyWith(
              color:
                  __.tab == index ? Theme.of(context).focusColor : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
