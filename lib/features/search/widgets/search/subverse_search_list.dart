import 'dart:developer';
import 'package:socialverse/export.dart';

class SubverseSearchList extends StatelessWidget {
  const SubverseSearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (_, __, ___) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          itemCount: __.search_history.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                log('tap');
                Navigator.of(context).pushNamed(
                  UserProfileScreen.routeName,
                  arguments: UserProfileScreenArgs(
                    username: __.search_history[index].username,
                  ),
                );
              },
              child: Container(
                height: 65,
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: cs.width(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CustomCircularAvatar(
                          imageUrl: __.search_history[index].profilePictureUrl,
                          height: 44,
                          width: 44,
                        ),
                      ],
                    ),
                    width10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            __.search_history[index].username,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          height5,
                          // Text(
                          //   __.search_history[index].,
                          //   style: Theme.of(context).textTheme.labelMedium,
                          //   maxLines: 1,
                          //   overflow: TextOverflow.ellipsis,
                          // ),
                        ],
                      ),
                    ),
                    width10,
                    InkWell(
                      onTap: (){
                        __.removeFromSearch(__.search_history[index]);
                      },
                      child: SvgPicture.asset(
                        AppAsset.icClose,
                        width: 24,
                        height: 24,
                      ),
                    ),
                    width5,
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
