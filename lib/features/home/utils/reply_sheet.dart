import 'package:socialverse/export.dart';
import 'package:socialverse/features/search/providers/video_provider.dart';


class ReplySheet extends StatelessWidget {
  final ViewVideoProvider viewVideoProvider;
  const ReplySheet({
    required this.viewVideoProvider,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return
      Consumer<SearchProvider>(
          builder: (_, __, ____){
            final ___ = viewVideoProvider;
            return Container(
              padding: const EdgeInsets.only(top: 20, left: 0, bottom: 20, right: 0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                color: Theme.of(context).canvasColor,
              ),
              child: SizedBox(
                // height: cs.height(context)/2,
                width: cs.width(context),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Expanded(
                            child: Center(
                                child: Text(
                                  'Replies',
                                  style: AppTextStyle.headlineMedium,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                                AppAsset.icClose,
                                fit: BoxFit.scaleDown,
                                color: Theme.of(context).indicatorColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      height20,
                      // if (!__.loading) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: GridView.builder(
                            controller: __.controller,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 20),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                              childAspectRatio: 0.65,
                            ),
                            itemCount: ___.replyPosts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SubversePostGridItem(
                                onTap: () {

                                  Navigator.pushNamed(
                                    context,
                                    VideoWidget.routeName,
                                    arguments: VideoWidgetArgs(
                                      posts: ___.replyPosts,
                                      pageController: PageController(initialPage: index),
                                      pageIndex: index,
                                    ),
                                  );

                                },
                                imageUrl: ___.replyPosts[index].thumbnailUrl,
                                createdAt: ___.replyPosts[index].createdAt,
                                viewCount: ___.replyPosts[index].viewCount,
                                username: ___.replyPosts[index].username,
                                pictureUrl: ___.replyPosts[index].pictureUrl,

                              );
                            },
                          ),
                        ),
                      // ],

                    ],
                  ),
                ),
              ),
            );;
          });
  }
}
