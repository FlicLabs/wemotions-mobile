import 'package:socialverse/export.dart';

class QrCodeProvider extends ChangeNotifier {
  final ScreenshotController screenshotController = ScreenshotController();

  Barcode? result;

  QRViewController? controller;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final qrImageDataUrl = 'https://beta.watchflic.com/@';

  bool _qrError = false;
  bool get qrError => _qrError;

  set qrError(bool value) {
    _qrError = value;
    notifyListeners();
  }

  saved(Uint8List image) async {
    await ImageGallerySaver.saveImage(image);
    print("File Saved to Gallery");
  }

  onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    notifyListeners();
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      notifyListeners();
    });
  }

  Future<void> onPermissionSet(
      BuildContext context, QRViewController ctrl, bool p) async {
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      floatingScaffold(context, message: 'No permission');
    }
  }

  floatingScaffold(context, {required String message}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.grey.shade900,
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white, fontSize: 14),
        ),
        margin: EdgeInsets.only(
          bottom: 100,
          right: 20,
          left: 20,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
