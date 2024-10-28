import 'package:socialverse/export.dart';
import 'package:socialverse/features/create/presentation/instant_camera_screen.dart';

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
    Container(),
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
    final reply = Provider.of<ReplyProvider>(context);
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    print("Is dark in stateful: $isDark");
    // print(MediaQuery.of(context).platformBrightness == Brightness.dark);

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
        floatingActionButton: CircularPercentIndicator(
          radius: 33,
          lineWidth: 4.0,
          backgroundColor: Colors.white,
          percent: 1,
          progressColor: isDark ? Colors.white : Color(0xFFA858F4),
          animation: true,
          addAutomaticKeepAlive: true,
          animationDuration: 1000,
          animateFromLastPercent: true,
          center: GestureDetector(
            onTap: nav.selectedVideoUploadType == "Video" ?  ()async {
              PermissionStatus status = await Permission.camera.request();
              if (logged_in == false) {
                auth.showAuthBottomSheet(context);
              }else {
                if (status.isDenied || status.isPermanentlyDenied) {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        CustomAlertDialog(
                          title: 'Permission Denied',
                          action: 'Open Settings',
                          content: 'Please allow access to camera to record videos',
                          tap: () {
                            openAppSettings();
                          },
                        ),
                  );
                } else {
                  PermissionStatus status = await Permission.camera.request();
                  if (status.isDenied || status.isPermanentlyDenied) {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          CustomAlertDialog(
                            title: 'Permission Denied',
                            action: 'Open Settings',
                            content: 'Please allow access to camera to record videos',
                            tap: () {
                              openAppSettings();
                            },
                          ),
                    );
                  } else {
                    await availableCameras().then(
                          (value) =>
                          Navigator.of(context).pushNamed(
                            CameraScreen.routeName,
                            arguments: CameraScreenArgs(cameras: value,
                                isReply: false),
                          ),
                    );
                  }
                }
              }
            } : ()async {
              // This is parent_video_id
              // .posts[.index].id
              // print(__.posts[__.index].id.toString());

              if (logged_in == false) {
                auth.showAuthBottomSheet(context);
              } else {
                PermissionStatus status =
                await Permission.camera.request();
                if (status.isDenied ||
                    status.isPermanentlyDenied) {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        CustomAlertDialog(
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
                  PermissionStatus status =
                  await Permission.camera.request();
                  if (status.isDenied ||
                      status.isPermanentlyDenied) {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          CustomAlertDialog(
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
                          (value) => Navigator.of(context)
                          .pushNamed(
                        CameraScreen.routeName,
                        arguments: CameraScreenArgs(
                            cameras: value,
                            isReply: true,
                            parent_video_id: home
                                .posts[home.index][0].id
                                .toString()),
                      ),
                    );
                  }
                }
              }
            },
            onLongPress:  nav.selectedVideoUploadType == "Video" ?  ()async  {
              PermissionStatus status = await Permission.camera.request();
              if (logged_in == false) {
                auth.showAuthBottomSheet(context);
              }else {
                if (status.isDenied || status.isPermanentlyDenied) {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        CustomAlertDialog(
                          title: 'Permission Denied',
                          action: 'Open Settings',
                          content: 'Please allow access to camera to record videos',
                          tap: () {
                            openAppSettings();
                          },
                        ),
                  );
                } else {
                  PermissionStatus status = await Permission.camera.request();
                  if (status.isDenied || status.isPermanentlyDenied) {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          CustomAlertDialog(
                            title: 'Permission Denied',
                            action: 'Open Settings',
                            content: 'Please allow access to camera to record videos',
                            tap: () {
                              openAppSettings();
                            },
                          ),
                    );
                  } else {
                    await availableCameras().then(
                          (value) =>
                          Navigator.of(context).pushNamed(
                            InstantCameraScreen.routeName,
                            arguments: InstantCameraScreenArgs(cameras: value,
                                isReply: false),
                          ),
                    );
                  }
                }
              }
            } : ()async {

            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration
                      : BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: new LinearGradient(
                        colors: [
                          Color(0xFFA858F4),
                          Color(0xFF9032E6),
                        ],
                        stops: [0.0, 1.0],
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        tileMode: TileMode.repeated
                    )
                  ),
                ),
                Container(
                  child: nav.selectedVideoUploadType == "Video" ? SvgPicture.asset(AppAsset.icvideopost) :  SvgPicture.asset(AppAsset.icreply),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: exit.isInit
            ? shrink
            : Container(
          height: 66,
              child: BottomNavigationBar(
                  currentIndex: nav.currentPage,
                  backgroundColor: Theme.of(context).canvasColor,
                  // backgroundColor: Color(0xFF2C2C2C),
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  selectedFontSize: 0,
                  onTap: (index) {
                    if (index == 2 && logged_in == false) {
                      auth.showAuthBottomSheet(context);
                    } else if (index == 2 && logged_in == false) {
                      auth.showAuthBottomSheet(context);
                    } else {
                      nav.currentPage = index;
                      if (home.posts.isNotEmpty) {
                        if (reply.posts.isNotEmpty) {
                          if (index == 2) {
                            if (home.horizontalIndex>0) {
                              reply.isPlaying = false;
                              reply.videoController(reply.index)?.pause();
                            } else {
                              home.isPlaying = false;
                              home.videoController(home.index)?.pause();
                            }
                          } else
                          {
                            if(home.horizontalIndex > 0)
                            {
                              reply.isPlaying = true;
                              reply.videoController(reply.index)?.play();
                            } else
                            {
                              home.isPlaying = true;
                              home.videoController(home.index)?.play();
                            }
                          }
                        } else
                        {
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
                      icon: nav.currentPage == 0 ?  SvgPicture.asset(
                        AppAsset.ichome_active,
                        height: 24,
                        width: 24,
                        // color: nav.currentPage == 0
                        //     ? Theme.of(context).hintColor
                        //     : Theme.of(context).primaryColorDark,
                      ) :SvgPicture.asset(
                        AppAsset.ichome,
                       color: Theme.of(context).focusColor,
                        height: 24,
                        width: 24,
                        // color: nav.currentPage == 0
                        //     ? Theme.of(context).hintColor
                        //     : Theme.of(context).primaryColorDark,
                      ),
                      label: '',
                    ),
                    // BottomNavigationBarItem(
                    //   icon:nav.currentPage == 1 ? SvgPicture.asset(
                    //     AppAsset.icdiscover_active,
                    //     height: 24,
                    //     width: 24,
                    //   ) : SvgPicture.asset(
                    //     AppAsset.icdiscover,
                    //     height: 24,
                    //     width: 24,
                    //   ),
                    //   label: '',
                    // ),
                    BottomNavigationBarItem(
                      icon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 38,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(onTap: (){

                                nav.selectedVideoUploadType = "Video";

                              },child: Text("Video",style: TextStyle(color: nav.selectedVideoUploadType == "Video" ? Theme.of(context).focusColor : Color(0xFF7C7C7C)),)),
                              width15,
                              GestureDetector(onTap: (){
                                nav.selectedVideoUploadType = "Reply";
                              },child: Text("Reply",style: TextStyle(color: nav.selectedVideoUploadType == "Reply" ? Theme.of(context).focusColor : Color(0xFF7C7C7C)))),
                            ],
                          )
                        ],
                      ),
                      label: '',
                    ),
                    // BottomNavigationBarItem(
                    //   icon:nav.currentPage == 1 ? SvgPicture.asset(
                    //     AppAsset.icnotification_active,
                    //     height: 24,
                    //     width: 24,
                    //   ) : SvgPicture.asset(
                    //     AppAsset.icnotification,
                    //     height: 24,
                    //     width: 24,
                    //   ),
                    //   label: '',
                    // ),
                    BottomNavigationBarItem(
                      icon:nav.currentPage == 2 ? SvgPicture.asset(
                        AppAsset.icuser_active,
                        height: 24,
                        width: 24,
                      ) : SvgPicture.asset(
                        AppAsset.icuser,
                        color: Theme.of(context).focusColor,
                        height: 24,
                        width: 24,
                      ),
                      label: '',
                    ),
                  ],
                ),
            ),
      ),
    );
  }
}
