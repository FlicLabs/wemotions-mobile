import 'dart:developer';
import 'package:socialverse/core/presentation/notifications.dart';
import 'package:socialverse/core/widgets/camera_button.dart';
import 'package:socialverse/core/widgets/camera_selector.dart';
import 'package:socialverse/export.dart';

class BottomNavBar extends StatefulWidget {
  static const String routeName = '/bottom-nav';
  const BottomNavBar({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => const BottomNavBar(),
    );
  }

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with WidgetsBindingObserver {
  final List<Widget> _screens = [
    HomeScreen(),
    SubverseScreen(),
    Container(),
    ActivityScreen(),
    ProfileScreen(),
  ];

  List<CameraDescription> localCameras = [];
  bool? isReply;
  bool wasPlayingBeforeCamera = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void _handleNavTap(int index, AuthProvider auth, HomeProvider home,
      BottomNavBarProvider nav, ReplyProvider reply) {
    if ((index == 3 || index == 4) && logged_in == false) {
      auth.showAuthBottomSheet(context);
      return;
    }

    setState(() {
      nav.currentPage = index;
    });

    if (home.posts.isNotEmpty) {
      bool isPlaying = index == 0;

      if (reply.posts.isNotEmpty) {
        if ([1, 2, 3, 4].contains(index)) {
          reply.isPlaying = home.horizontalIndex > 0 ? false : false;
          reply.videoController(reply.index)?.pause();
        } else {
          reply.isPlaying = home.horizontalIndex > 0 ? true : true;
          reply.videoController(reply.index)?.play();
        }
      } else {
        home.isPlaying = isPlaying;
        home.videoController(home.index)?.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    final exit = Provider.of<ExitProvider>(context);
    final nav = Provider.of<BottomNavBarProvider>(context);
    final reply = Provider.of<ReplyProvider>(context);
    final camera = Provider.of<CameraProvider>(context);
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.black,
            body: IndexedStack(
              index: nav.currentPage,
              children: _screens,
            ),
            bottomNavigationBar: camera.showCameraScreen
                ? const SizedBox.shrink()
                : (exit.isInit ? shrink : _BottomNavBarItems(nav, auth, home, reply, _handleNavTap)),
          ),
          if (camera.showCameraScreen)
            CameraScreen(
              cameras: localCameras,
              isReply: isReply ?? false,
              parent_video_id: nav.parentVideoId,
            ),
          _FloatingCameraButton(isDark: isDark, nav: nav, camera: camera, auth: auth),
        ],
      ),
    );
  }
}

/// 📌 **Extracted Bottom Navigation Bar Items**
class _BottomNavBarItems extends StatelessWidget {
  final BottomNavBarProvider nav;
  final AuthProvider auth;
  final HomeProvider home;
  final ReplyProvider reply;
  final Function(int, AuthProvider, HomeProvider, BottomNavBarProvider, ReplyProvider) onTap;

  const _BottomNavBarItems(this.nav, this.auth, this.home, this.reply, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: nav.currentPage,
      backgroundColor: Theme.of(context).canvasColor,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedFontSize: 0,
      onTap: (index) => onTap(index, auth, home, nav, reply),
      items: [
        _buildNavItem(context, AppAsset.ichome, AppAsset.ichome_active, 0),
        _buildNavItem(context, AppAsset.icdiscover, AppAsset.icdiscover_active, 1),
        const BottomNavigationBarItem(icon: CameraModeSelector(), label: ''),
        _buildNavItem(context, AppAsset.icnotification, AppAsset.icnotification_active, 3),
        _buildNavItem(context, AppAsset.icuser, AppAsset.icuser_active, 4),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(BuildContext context, String icon, String activeIcon, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        nav.currentPage == index ? activeIcon : icon,
        height: 24,
        width: 24,
        color: nav.currentPage == index ? null : Theme.of(context).focusColor,
      ),
      label: '',
    );
  }
}

/// 📌 **Floating Camera Button**
class _FloatingCameraButton extends StatelessWidget {
  final bool isDark;
  final BottomNavBarProvider nav;
  final CameraProvider camera;
  final AuthProvider auth;

  const _FloatingCameraButton({
    required this.isDark,
    required this.nav,
    required this.camera,
    required this.auth,
    Key? key,
  }) : super(key: key);

  void _handleLongPress(BuildContext context) async {
    PermissionStatus status = await Permission.camera.request();
    await Permission.storage.request();

    if (logged_in == false) {
      auth.showAuthBottomSheet(context);
    } else if (status.isDenied || status.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Permission Denied',
          action: 'Open Settings',
          content: 'Please allow access to camera to record videos',
          tap: () => openAppSettings(),
        ),
      );
    } else {
      await availableCameras().then((value) {
        camera.shouldStartRecording = true;
        camera.showCameraScreen = true;
        log('DEBUG: Show camera screen and start recording');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: Platform.isIOS ? 68 : 35,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onLongPress: () => _handleLongPress(context),
          child: CameraButton(isDark: isDark, nav: nav),
        ),
      ),
    );
  }
}
