import 'package:socialverse/export.dart';

class BottomNavBarArgs {
  final PendingDynamicLinkData? initialLink;
  const BottomNavBarArgs({this.initialLink});
}

class BottomNavBar extends StatefulWidget {
  static const String routeName = '/bottom-nav';
  const BottomNavBar({Key? key, this.initialLink}) : super(key: key);

  static Route route({required BottomNavBarArgs args}) {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => BottomNavBar(
        initialLink: args.initialLink,
      ),
    );
  }

  final PendingDynamicLinkData? initialLink;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with WidgetsBindingObserver {
  final linkRepository = DynamicLinkRepository();

  final List<Widget> _screens = [
    HomeScreen(),
    // SubverseScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    linkRepository.retrieveDynamicLink(context);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    final exit = Provider.of<ExitProvider>(context);
    final nav = Provider.of<BottomNavBarProvider>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        // extendBody: true,
        body: IndexedStack(
          index: nav.currentPage,
          children: _screens,
        ),
        bottomNavigationBar: exit.isInit
            ? shrink
            : BottomNavigationBar(
                currentIndex: nav.currentPage,
                backgroundColor: nav.currentPage == 0
                    ? Colors.black
                    : Theme.of(context).primaryColor,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedFontSize: 0,
                onTap: (index) {
                  if (index == 1 && logged_in == false) {
                    auth.showAuthBottomSheet(context);
                  } else if (index == 1 && logged_in == false) {
                    auth.showAuthBottomSheet(context);
                  } else {
                    nav.currentPage = index;
                    if (home.posts.isNotEmpty) {
                      if (index == 0 && home.isPlaying == false) {
                        home.isPlaying = true;
                        home.videoController(home.index)?.play();
                      } else {
                        home.isPlaying = false;
                        home.videoController(home.index)?.pause();
                      }
                    }
                  }
                },
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppAsset.ichome,
                      height: 30,
                      width: 30,
                      color: nav.currentPage == 0
                          ? Theme.of(context).hintColor
                          : Theme.of(context).primaryColorDark,
                    ),
                    label: '',
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Image.asset(
                  //     AppAsset.icon,
                  //     height: 50,
                  //     width: 50,
                  //     color: nav.currentPage == 1
                  //         ? Theme.of(context).hintColor
                  //         : Theme.of(context).primaryColorDark,
                  //   ),
                  //   label: '',
                  // ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppAsset.icuser,
                      height: 30,
                      width: 30,
                      color: nav.currentPage == 1
                          ? Theme.of(context).hintColor
                          : Theme.of(context).primaryColorDark,
                    ),
                    label: '',
                  ),
                ],
              ),
      ),
    );
  }
}
