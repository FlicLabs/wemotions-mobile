import 'package:socialverse/export.dart';

class EmptyState extends StatefulWidget {
  const EmptyState({super.key});

  @override
  State<EmptyState> createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState> {

  late final HomeProvider home;

  @override
  void initState() {
    super.initState();
    home=Provider.of<HomeProvider>(context,listen: false);
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Stack(
        children: [
          if (home.posts.isEmpty) ...[
            Center(child: CustomProgressIndicator()),
            Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Container(
                height: cs.height(context),
                width: cs.width(context),
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
            Positioned(
              bottom: cs.height(context) * 0.115,
              child: Container(
                height: 4.5,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
