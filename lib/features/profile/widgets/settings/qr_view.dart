import 'package:socialverse/export.dart';

class QrView extends StatelessWidget {
  const QrView({super.key});

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 500 ||
            MediaQuery.of(context).size.height < 500)
        ? 150.0
        : 350.0;
    return Consumer<QrCodeProvider>(
      builder: (_, __, ___) {
        return QRView(
          key: __.qrKey,
          onQRViewCreated: __.onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: Theme.of(context).hintColor,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea),
          onPermissionSet: (ctrl, p) => __.onPermissionSet(context, ctrl, p),
        );
      },
    );
  }
}
