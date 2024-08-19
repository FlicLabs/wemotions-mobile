import 'package:socialverse/export.dart';

class ExitVideoWidget extends StatelessWidget {
  const ExitVideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExitProvider>(
      builder: (_, __, ___) {
        return __.isInit && __.controller!.value.isInitialized
            ? SizedBox(
                height: cs().height(context),
                width: cs().width(context),
                child: SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: __.controller!.value.size.width,
                      height: __.controller!.value.size.height,
                      child: VideoPlayer(__.controller!),
                    ),
                  ),
                ),
              )
            : shrink;
      },
    );
  }
}
