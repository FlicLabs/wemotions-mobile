import 'package:socialverse/export.dart';

class CustomImagePicker extends StatelessWidget {
  const CustomImagePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraProvider>(
      builder: (_, __, ___) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 50,
              width: 50,
              child: GestureDetector(
                onTap: () {
                  __.imagePicker(context);
                },
                child: Center(
                  child: SvgPicture.asset(
                    AppAsset.icupload,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
