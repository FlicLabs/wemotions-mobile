import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/utils/empty_state.dart';
import 'package:socialverse/features/home/utils/exit_toggle.dart';
import 'package:socialverse/features/home/utils/exit_video_widget.dart';

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
          //temp branch
          backgroundColor: Colors.black,
          resizeToAvoidBottomInset: false,
          body: RefreshIndicator(
            color: Theme.of(context).hintColor,
            backgroundColor: Colors.black,
            onRefresh: () async => __.onRefresh(),
            child: Stack(
              children: [
                EmptyState(),
                if (__.posts.isNotEmpty) ...[
                  HomeVideoWidget(
                    posts: __.posts,
                    pageController: __.home,
                    pageIndex: 0,
                    isFromFeed: true,
                  )
                ],
                ExitToggle(),
                PostUploadIndicator(),
                ExitVideoWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
