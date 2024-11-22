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
          height: 42,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (nav.currentPage == 0) ...[
              GestureDetector(
                onTap: () {
                  nav.selectedVideoUploadType = "Video";
                },
                child: Text(
                  "Video",
                  style: TextStyle(
                      color: nav.selectedVideoUploadType == "Video"
                          ? Theme.of(context).focusColor
                          : Color(0xFF7C7C7C)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  nav.selectedVideoUploadType = "Reply";
                },
                child: Text(
                  "Reply",
                  style: TextStyle(
                    color: nav.selectedVideoUploadType == "Reply"
                        ? Theme.of(context).focusColor
                        : Color(0xFF7C7C7C),
                  ),
                ),
              ),
            ] else ...[
              GestureDetector(
                onTap: () {
                  nav.selectedVideoUploadType = "Video";
                },
                child: Text(
                  "Video",
                  style: TextStyle(
                      color: nav.selectedVideoUploadType == "Video"
                          ? Theme.of(context).focusColor
                          : Color(0xFF7C7C7C)),
                ),
              ),
            ]
          ],
        )
      ],
    );
  }
}