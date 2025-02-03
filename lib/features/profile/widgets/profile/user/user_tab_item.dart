import 'package:socialverse/export.dart';

class UserTabItem extends StatelessWidget {
  const UserTabItem({
    Key? key,
    required this.label,
    required this.index,
    this.username,
  }) : super(key: key);

  final String label;
  final int index;
  final String? username;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (_, __, ___) {
        return InkWell(
          onTap: () {
            __.onTabChanged(index);
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
