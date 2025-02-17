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
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        color: Theme.of(context).hintColor,
        backgroundColor: Colors.black,
        onRefresh: () async => context.read<HomeProvider>().onRefresh(),
        child: Stack(
          children: [
            Consumer<HomeProvider>(
              builder: (context, homeProvider, child) {
                return homeProvider.posts.isEmpty
                    ? EmptyState()
                    : HomeVideoWidget(
                        posts: homeProvider.posts,
                        pageController: homeProvider.home,
                        pageIndex: homeProvider.currentIndex,
                        isFromFeed: true,
                      );
              },
            ),
            const ExitToggle(),
            const PostUploadIndicator(),
            const ExitVideoWidget(),
          ],
        ),
      ),
    );
  }
}
