import 'dart:developer';
import 'package:socialverse/export.dart';

class SubverseSearchList extends StatelessWidget {
  const SubverseSearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final subscription = Provider.of<SubscriptionProvider>(context);
    return Consumer<SearchProvider>(
      builder: (_, __, ___) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          itemCount: __.subverse_search.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                log('tap');
                if (__.subverse_search[index].hasAccess == false) {
                  HapticFeedback.mediumImpact();
                  // subscription.startSubscription(
                  //   id: __.subverse_search[index].id,
                  // );
                  // log('subscription');
                } else {
                  // __.onSubverseTap(
                  //   context: context,
                  //   category_id: __.subverse_search[index].id,
                  //   category_count: __.subverse_search[index].count,
                  //   category_desc: __.subverse_search[index].description,
                  //   category_name: __.subverse_search[index].name,
                  //   category_photo: __.subverse_search[index].imageUrl,
                  // );
                }
              },
              child: Container(
                height: 65,
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: cs().width(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CustomCircularAvatar(
                          imageUrl: __.subverse_search[index].imageUrl,
                          height: 55,
                          width: 55,
                        ),
                        if (__.subverse_search[index].hasAccess == false)
                          Positioned(
                            bottom: 0,
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Icon(
                                Icons.lock,
                                color: Colors.black,
                                size: 35,
                              ),
                            ),
                          )
                      ],
                    ),
                    width10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            __.subverse_search[index].name,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          height5,
                          Text(
                            __.subverse_search[index].description,
                            style: Theme.of(context).textTheme.labelMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
