import 'package:socialverse/export.dart';

class InternetError {
  static final _instance = InternetError.internal();
  factory InternetError() => _instance;
  InternetError.internal();

  static OverlayEntry? entry;

  void show(context, page) => addOverlayEntry(context);
  void hide() => removeOverlay();

  bool get isShow => entry != null;

  addOverlayEntry(context) {
    if (entry != null) return;
    entry = OverlayEntry(builder: (BuildContext context) {
      return LayoutBuilder(builder: (_, BoxConstraints constraints) {
        return Material(
          color: Colors.white,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/gif/no-internet.gif',
                  height: 250,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Please check your internet connection!",
                  // ignore: unnecessary_const
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                // ImageButton(
                //   title: 'Okay',
                //   onPressed: () {
                //     removeOverlay();
                //   },
                // )
              ],
            ),
          ),
        );
      });
    });

    addoverlay(entry!, context);
  }

  addoverlay(OverlayEntry entry, context) async {
    Overlay.of(context).insert(entry);
  }

  removeOverlay() {
    entry?.remove();
    entry = null;
  }
}
