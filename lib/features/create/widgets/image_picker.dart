import 'package:socialverse/export.dart';

class CustomImagePicker extends StatelessWidget {
  const CustomImagePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraProvider>(
      builder: (context, cameraProvider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.2), // Adds subtle background
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () => cameraProvider.imagePicker(context),
                child: Center(
                  child: SvgPicture.asset(
                    AppAsset.icupload,
                    color: Colors.white,
                    height: 30,
                    width: 30,
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
