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
      pageBuilder: (_, __, ___) => BottomNavBar(),
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

  List<CameraDescription> local_value = [];
  String? parent_video_id;
  bool? isReply;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
            resizeToAvoidBottomInset: true,
            body: IndexedStack(
              index: nav.currentPage,
              children: _screens,
            ),
            bottomNavigationBar: camera.showCameraScreen
                ? const SizedBox(
                    height: 0,
                  )
                : (exit.isInit
                    ? shrink
                    : Container(
                        height: 100,
                        child: BottomNavigationBar(
                          currentIndex: nav.currentPage,
                          backgroundColor: Theme.of(context).canvasColor,
                          type: BottomNavigationBarType.fixed,
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          selectedFontSize: 0,
                          onTap: (index) {
                            if (index == 3 && logged_in == false) {
                              auth.showAuthBottomSheet(context);
                            } else if (index == 4 && logged_in == false) {
                              auth.showAuthBottomSheet(context);
                            } else {
                              nav.currentPage = index;
                              if (home.posts.isNotEmpty) {
                                if (reply.posts.isNotEmpty) {
                                  if (index == 1 ||
                                      index == 2 ||
                                      index == 3 ||
                                      index == 4) {
                                    if (home.horizontalIndex > 0) {
                                      reply.isPlaying = false;
                                      reply
                                          .videoController(reply.index)
                                          ?.pause();
                                    } else {
                                      home.isPlaying = false;
                                      home.videoController(home.index)?.pause();
                                    }
                                  } else {
                                    if (home.horizontalIndex > 0) {
                                      reply.isPlaying = true;
                                      reply
                                          .videoController(reply.index)
                                          ?.play();
                                    } else {
                                      home.isPlaying = true;
                                      home.videoController(home.index)?.play();
                                    }
                                  }
                                } else {
                                  if (index == 0 && home.isPlaying == false) {
                                    home.isPlaying = true;
                                    home.videoController(home.index)?.play();
                                  } else {
                                    home.isPlaying = false;
                                    home.videoController(home.index)?.pause();
                                  }
                                }
                              }
                            }
                          },
                          items: [
                            BottomNavigationBarItem(
                                icon: nav.currentPage == 0
                                    ? SvgPicture.asset(
                                        AppAsset.ichome_active,
                                        height: 24,
                                        width: 24,
                                      )
                                    : SvgPicture.asset(
                                        AppAsset.ichome,
                                        color: Theme.of(context).focusColor,
                                        height: 24,
                                        width: 24,
                                      ),
                                label: ''),
                            BottomNavigationBarItem(
                                icon: nav.currentPage == 1
                                    ? SvgPicture.asset(
                                        AppAsset.icdiscover_active,
                                        height: 24,
                                        width: 24,
                                      )
                                    : SvgPicture.asset(
                                        AppAsset.icdiscover,
                                        color: Theme.of(context).focusColor,
                                        height: 24,
                                        width: 24,
                                      ),
                                label: ''),
                            BottomNavigationBarItem(
                                icon: CameraModeSelector(nav: nav), label: ''),
                            BottomNavigationBarItem(
                                icon: nav.currentPage == 3
                                    ? SvgPicture.asset(
                                        AppAsset.icnotification_active,
                                        height: 24,
                                        width: 24,
                                      )
                                    : SvgPicture.asset(
                                        AppAsset.icnotification,
                                        color: Theme.of(context).focusColor,
                                        height: 24,
                                        width: 24,
                                      ),
                                label: ''),
                            BottomNavigationBarItem(
                                icon: nav.currentPage == 4
                                    ? SvgPicture.asset(
                                        AppAsset.icuser_active,
                                        height: 24,
                                        width: 24,
                                      )
                                    : SvgPicture.asset(
                                        AppAsset.icuser,
                                        color: Theme.of(context).focusColor,
                                        height: 24,
                                        width: 24,
                                      ),
                                label: ''),
                          ],
                        ),
                      )),
          ),
          if (camera.showCameraScreen) ...[
            CameraScreen(
              cameras: local_value,
              isReply: isReply!,
              parent_video_id: parent_video_id,
            ),
          ],
          Positioned(
            bottom: 65,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  if (!camera.showCameraScreen) ...[
                    GestureDetector(
                      onLongPress: () async {
                        PermissionStatus status =
                            await Permission.camera.request();
                        if (logged_in == false) {
                          auth.showAuthBottomSheet(context);
                        } else {
                          if (status.isDenied || status.isPermanentlyDenied) {
                            showDialog(
                              context: context,
                              builder: (context) => CustomAlertDialog(
                                title: 'Permission Denied',
                                action: 'Open Settings',
                                content:
                                    'Please allow access to camera to record videos',
                                tap: () {
                                  openAppSettings();
                                },
                              ),
                            );
                          } else {
                            await availableCameras().then(
                              (value) async {
                                local_value = value;
                                isReply = nav.selectedVideoUploadType == 'Video'
                                    ? false
                                    : true;
                                camera.shouldStartRecording = true;
                                camera.showCameraScreen = true;
                                log('DEBUG: Show camera screen and start recording');
                              },
                            );
                          }
                        }
                      },
                      child: CameraButton(isDark: isDark, nav: nav),
                    ),
                  ],
                  if (camera.showCameraScreen) ...[RecordButton()]
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
