import 'package:socialverse/export.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, __, ___) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: [
              if (__.posts.isEmpty) ...[
                // Center(child: CustomProgressIndicator())
                Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Container(
                    height: cs().height(context),
                    width: cs().width(context),
                    color: Colors.black,
                    child: Center(
                      child: Image.asset(
                        AppAsset.icon,
                        color: Colors.white,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: cs().height(context) * 0.115,
                //   child: Container(
                //     height: 4.5,
                //     color: Colors.white,
                //     width: MediaQuery.of(context).size.width,
                //   ),
                // ),
              ],
            ],
          ),
        );
      },
    );
  }
}
