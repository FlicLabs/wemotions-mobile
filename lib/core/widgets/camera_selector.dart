import 'package:socialverse/export.dart';

class CameraModeSelector extends StatelessWidget {
  const CameraModeSelector({
    super.key,
    required this.nav,
  });

  final BottomNavBarProvider nav;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
          height: 40,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    nav.selectedVideoUploadType = "Video";
                  },
                  child: Text(
                    "Video",
                    style: TextStyle(
                        color: nav.selectedVideoUploadType == "Video"
                            ? Theme.of(context).focusColor
                            : const Color(0xFF7C7C7C),
                        fontSize: nav.currentPage == 0 ? 38 : 13.5),
                  ),
                ),
              ),
              if (nav.currentPage == 0)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      nav.selectedVideoUploadType = "Reply";
                    },
                    child: Text(
                      "Reply",
                      style: TextStyle(
                          color: nav.selectedVideoUploadType == "Reply"
                              ? Theme.of(context).focusColor
                              : const Color(0xFF7C7C7C),
                          fontSize: 38),
                    ),
                  ),
                ),
            ],
          ),
        ),
        // height5,
      ],
    );
  }
}
