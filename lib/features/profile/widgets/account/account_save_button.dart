import 'package:socialverse/export.dart';

class AccountSaveButton extends StatelessWidget {
  const AccountSaveButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (_, __, ___) {
        return GestureDetector(
          onTap: onTap,
          child: Text(
            'Done',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 15,
                  color: __.edited == false
                      ? Colors.grey
                      : Theme.of(context).hintColor,
                ),
            textAlign: TextAlign.start,
          ),
        );
      },
    );
  }
}
