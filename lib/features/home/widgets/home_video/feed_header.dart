import 'package:socialverse/export.dart';

class FeedHeader extends StatelessWidget {
  const FeedHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, __, ___) {
        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5, left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FeedButton(
                      onTap: () {
                        // __.subscribed = true;
                      },
                      title: 'Subscribed',
                      textColor: __.subscribed == true
                          ? Colors.white
                          : Colors.grey.shade400,
                      buttonColor: __.subscribed == true
                          ? Colors.white.withOpacity(0.25)
                          : Colors.transparent,
                      isSelected: __.subscribed == true,
                    ),
                    FeedButton(
                      onTap: () {
                        // __.subscribed = false;
                      },
                      title: 'Discover',
                      textColor: __.subscribed == false
                          ? Colors.white
                          : Colors.grey.shade400,
                      buttonColor: __.subscribed == false
                          ? Colors.white.withOpacity(0.25)
                          : Colors.transparent,
                      isSelected: __.subscribed == false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
