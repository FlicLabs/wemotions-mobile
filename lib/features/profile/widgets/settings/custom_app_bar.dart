import 'package:socialverse/export.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.child,
    required this.title,
  }) : super(key: key);

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CustomIconButton(
                        icon: Icons.arrow_back_ios_new_rounded,
                        borderRadius: 12,
                        onTap: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    // width: 100,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.normalBold,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Platform.isAndroid ? height40 : shrink,
        Expanded(
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Theme.of(context).primaryColor,
            ),
            child: SizedBox(
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
