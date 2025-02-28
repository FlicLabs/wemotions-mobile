import 'package:socialverse/export.dart';

class Circle {
  static final _instance = Circle.internal();
  factory Circle() => _instance;
  Circle.internal();

  static bool entry = false;
  static OverlayEntry viewEntry = OverlayEntry(builder: (BuildContext context) {
    return const CustomProgressIndicator();
  });

  InternetError internetError = InternetError();

  show(context) async {
    return addOverlayEntry(context);
  }

  void hide(context) => removeOverlay();

  bool get isShow => isShowNetworkOrCircle();

  bool isShowNetworkOrCircle() {
    return internetError.isShow || entry == true;
  }

  addOverlayEntry(context) async {
    if (entry == true) return;
    entry = true;
    return addOverlay(viewEntry, context);
  }

  addOverlay(OverlayEntry entry, context) async {
    try {
      return Overlay.of(context).insert(entry);
    } catch (e) {
      return Future.error(e);
    }
  }

  removeOverlay() async {
    try {
      entry = false;
      viewEntry.remove();
    } catch (e) {
      return Future.error(e);
    }
  }
}

class CustomProgressIndicator extends StatelessWidget {
  final Color? color;
  const CustomProgressIndicator({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Theme.of(context).hintColor,
                  strokeWidth: 5,
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                top: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    AppAsset.icon,
                    color: color ?? Theme.of(context).hintColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
