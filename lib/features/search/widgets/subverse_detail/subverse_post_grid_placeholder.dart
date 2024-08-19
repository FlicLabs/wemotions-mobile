import 'package:socialverse/export.dart';

class SubversePostGridPlaceholder extends StatelessWidget {
  const SubversePostGridPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 500,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey,
              ),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              child: Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    color: Colors.grey,
                  ),
                  width5,
                  Container(
                    width: 30,
                    height: 10,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
