import 'package:socialverse/export.dart';

class QRScanner extends StatefulWidget {
  static const String routeName = '/qr-code-scanner';

  const QRScanner({super.key});
  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => QRScanner(),
    );
  }

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final controller = QrCodeProvider().controller;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QrCodeProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: QrView(),
                  ),
                ],
              ),
              Positioned(
                top: 50,
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Navigator.of(context).pop();
                      __.controller!.dispose();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 16,
                    ),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
