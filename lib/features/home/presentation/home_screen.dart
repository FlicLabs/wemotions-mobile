import 'package:socialverse/export.dart';

import '../widgets/home_video/post_upload_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<HomeProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          backgroundColor: Colors.black,
          resizeToAvoidBottomInset: false,
          body: RefreshIndicator(
            color: Theme.of(context).hintColor,
            backgroundColor: Colors.black,
            onRefresh: () async => __.onRefresh(),
            // onRefresh: ()async{},
            child: Stack(
              children: [
                EmptyState(),
                if (__.posts.isNotEmpty) ...[
                  HomeVideoWidget(
                    posts: __.posts,
                    pageController: __.home,
                    pageIndex: 0,
                    isFromFeed: true,
                  ),
                  Positioned(child: PostUploadIndicator(),bottom: __.heightOfUserInfoBar,),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

