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
    const HomeScreen(),
    const SubverseScreen(),
    Container(),
    const ActivityScreen(),
    const ProfileScreen(),
  ];

  List<CameraDescription> localCameras = [];
  bool isReply = false;
  bool wasPlayingBeforeCamera = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> _requestCameraPermissions(BuildContext context) async {
    final PermissionStatus cameraStatus = await Permission.camera.request();
    await Permission.storage.request();

    if (cameraStatus.isDenied || cameraStatus.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Permission Denied',
          action: 'Open Settings',
          content: 'Please allow access to the camera to record videos',
          tap: openAppSettings,
        ),
      );
    } else {
      await availableCameras().then((value) {
        setState(() {
          localCameras = value;
          isReply = Provider.of<BottomNavBarProvider>(context, listen: false)
                  .selectedVideoUploadType ==
              'Video';
          Provider.of<CameraProvider>(context, listen: false)
            ..shouldStartRecording = true
            ..showCameraScreen = true;
          log('DEBUG: Show camera screen and start recording');
        });
      });
    }
  }

  void _handleVideoPlayback(HomeProvider home, ReplyProvider reply, int index) {
    if (index == 0 && !home.isPlaying) {
      home.isPlaying = true;
      home.videoController(home.index)?.play();
    } else {
      home.isPlaying = false;
      home.videoController(home.index)?.pause();
    }

    if (reply.posts.isNotEmpty && home.horizontalIndex > 0) {
      reply.isPlaying = index == 0;
      if (reply.isPlaying) {
        reply.videoController(reply.index)?.play();
      } else {
        reply.videoController(reply.index)?.pause();
      }
    }
  }

  BottomNavigationBarItem _buildNavItem(
      String activeIcon, String inactiveIcon, int index, BottomNavBarProvider nav) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        nav.currentPage == index ? activeIcon : inactiveIcon,
        height: 24,
        width: 24,
        color: nav.currentPage == index ? null : Theme.of(context).focusColor,
      ),
      label: '',
    );
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

    if (camera.showCameraScreen && home.isPlaying) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        wasPlayingBeforeCamera = true;
        home.isPlaying = false;
        home.videoController(home.index)?.pause();
      });
    } else if (!camera.showCameraScreen && wasPlayingBeforeCamera) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        wasPlayingBeforeCamera = false;
        home.isPlaying = true;
        home.videoController(home.index)?.play();
      });
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.black,
            resizeToAvoidBottomInset: true,
            body: IndexedStack(
              index: nav.currentPage,
              children: _screens,
            ),
            bottomNavigationBar: camera.showCameraScreen
                ? const SizedBox.shrink()
                : exit.isInit
                    ? shrink
                    : BottomNavigationBar(
                        currentIndex: nav.currentPage,
                        backgroundColor: Theme.of(context).canvasColor,
                        type: BottomNavigationBarType.fixed,
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        selectedFontSize: 0,
                        onTap: (index) {
                          if ((index == 3 || index == 4) && !logged_in) {
                            auth.showAuthBottomSheet(context);
                          } else {
                            nav.currentPage = index;
                            _handleVideoPlayback(home, reply, index);
                          }
                        },
                        items: [
                          _buildNavItem(AppAsset.ichome_active, AppAsset.ichome, 0, nav),
                          _buildNavItem(AppAsset.icdiscover_active, AppAsset.icdiscover, 1, nav),
                          const BottomNavigationBarItem(icon: CameraModeSelector(), label: ''),
                          _buildNavItem(AppAsset.icnotification_active, AppAsset.icnotification, 3, nav),
                          _buildNavItem(AppAsset.icuser_active, AppAsset.icuser, 4, nav),
                        ],
                      ),
          ),
          if (camera.showCameraScreen)
            CameraScreen(
              cameras: localCameras,
              isReply: isReply,
              parent_video_id: nav.parentVideoId,
            ),
          Positioned(
            bottom: Platform.isIOS ? 68 : 35,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  if (!camera.showCameraScreen)
                    GestureDetector(
                      onLongPress: () => _requestCameraPermissions(context),
                      child: CameraButton(isDark: isDark, nav: nav),
                    ),
                  if (camera.showCameraScreen) const RecordButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
