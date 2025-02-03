import 'package:socialverse/export.dart';

import '../providers/bottom_nav_provider.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    Key? key,
    required this.onTap,
    required this.index,
    required this.child,
    this.onDoubleTap,
  }) : super(key: key);

  final VoidCallback onTap;
  final int index;
  final Widget child;
  final void Function()? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarProvider>(
      builder: (_, __, ___) {
        return Expanded(
          child: GestureDetector(
            onTap: onTap,
            onDoubleTap: onDoubleTap,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return __.currentPage == index
                    ? LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Theme.of(context).hintColor,
                          Theme.of(context).hintColor,
                        ],
                        tileMode: TileMode.repeated,
                      ).createShader(bounds)
                    : const LinearGradient(
                        colors: <Color>[Colors.white, Colors.white],
                      ).createShader(bounds);
              },
              child: child,
            ),
          ),
        );
      },
    );
  }
}
