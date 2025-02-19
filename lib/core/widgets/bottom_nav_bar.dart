import 'dart:developer';
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
    // Container(),
    SubverseScreen(),
    Container(),
    ActivityScreen(),
    ProfileScreen(),
  ];


  bool wasPlayingBeforeCamera = false;

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
    final notification = Provider.of<NotificationProvider>(context);
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

    Future<bool> _checkAndRequestPermissions(BuildContext context) async {
      if (!logged_in!) {
        auth.showAuthBottomSheet(context);
        return false;
      }


      try {
        // First check current camera permission status
        PermissionStatus cameraStatus = await Permission.camera.status;
        print('Camera Status: $cameraStatus');

        // If camera permission is denied, request it
        if (cameraStatus.isDenied) {
          cameraStatus = await Permission.camera.request();
          print('Camera Status after request: $cameraStatus');

          // If the user denies the permission permanently, show the dialog to open settings
          if (cameraStatus.isPermanentlyDenied) {
            if (context.mounted) {
              bool? shouldOpenSettings = await showDialog<bool>(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Permission Required',
                  action: 'Open Settings',
                  content: 'Please allow camera access to record videos',
                  tap: () {
                    Navigator.pop(context, true);
                  },
                ),
              );

              if (shouldOpenSettings == true) {
                await openAppSettings();
                return false;
              }
            }
            return false;
          }

          // If the user denies the permission temporarily, just return false
          if (cameraStatus.isDenied) {
            return false;
          }
        }

        // If camera permission is granted, proceed with storage permission
        if (cameraStatus.isGranted) {
          setState(() {

          });
          PermissionStatus storageStatus = await Permission.storage.status;
          print('Storage Status: $storageStatus');

          // If storage permission is denied, request it
          if (storageStatus.isDenied) {
            storageStatus = await Permission.storage.request();
            print('Storage Status after request: $storageStatus');

            // Wait for the user's response to the storage permission request
            if (storageStatus.isPermanentlyDenied) {
              if (context.mounted) {
                bool? shouldOpenSettings = await showDialog<bool>(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Permission Required',
                    action: 'Open Settings',
                    content: 'Please allow storage access to record videos',
                    tap: () {
                      Navigator.pop(context, true);
                    },
                  ),
                );

                if (shouldOpenSettings == true) {
                  await openAppSettings();
                  return false;
                }
              }
              return false;
            }

            // If the user denies the storage permission temporarily, just return false
            // if (storageStatus.isDenied) {
            //   return false;
            // }
          }

          // Return true only if both permissions are granted
          return cameraStatus.isGranted ;
        }

        return false;
      } catch (e) {
        print('Error checking permissions: $e');
        return false;
      }
    }

    void _onVerticalDragUpdate(DragUpdateDetails details) {
      if (camera.isRecordingLocked) return;

      double sensitivity = 0.005;
      double delta = details.delta.dy * sensitivity;

      // Invert delta to make upward drag increase zoom
      double newZoom = camera.currentZoomLevel - delta;

      // Clamp zoom level
      newZoom = newZoom.clamp(
        camera.minZoomLevel,
        camera.maxZoomLevel,
      );

      camera.currentZoomLevel = newZoom;

      // Set the new zoom level via provider
      camera.setZoomLevel(camera.currentZoomLevel);
    }


    return WillPopScope(
      onWillPop: () async{
        if(camera.showCameraScreen){
          await camera.resetValues(isDisposing: true);
        }
        return false;
      },
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
                ? const SizedBox(height: 0)
                : (exit.isInit
                    ? shrink
                    : Container(
                        height: Platform.isIOS ? 100 : 70,
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

                              if(index!=0 && nav.selectedVideoUploadType=='Reply'){
                                nav.selectedVideoUploadType='Video';
                              }

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

                              if (index==3){
                                notification.notifications.forEach((element) async{
                                  await notification.readActivity(element.id);
                                });
                                notification.notSeenNotification=0;
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
                              label: '',
                            ),
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
                              label: '',
                            ),
                            BottomNavigationBarItem(
                                icon: CameraModeSelector(nav: nav), label: ''),
                            BottomNavigationBarItem(
                              icon: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  nav.currentPage == 3
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

                                  if(notification.notSeenNotification!=0) Positioned(
                                    right: -1,
                                    top: -2,
                                    child: Container(
                                      // padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      constraints: BoxConstraints(
                                        minHeight: 12,
                                        minWidth: 12,
                                      ),
                                      child: Text('${notification.notSeenNotification}',style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                                    ),
                                  )
                                ],
                              ),
                              label: '',
                            ),
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
                              label: '',
                            ),
                          ],
                        ),
                      )),
          ),
          if (camera.showCameraScreen) ...[
            CameraScreen(
              cameras: camera.localValue,
              isReply: camera.isReply,
              parent_video_id: nav.parentVideoId,
            ),
          ],
          Positioned(
            bottom: Platform.isIOS ? 68 : 35,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  // if (!camera.showCameraScreen) ...[
                  //   GestureDetector(
                  //     onTap: () async {
                  //
                  //       bool permissionsGranted = await _checkAndRequestPermissions(context);
                  //       print("${permissionsGranted} ontap");
                  //       if (permissionsGranted) {
                  //         camera.hasPermission = true;
                  //         print("${true} ontap");
                  //       }
                  //     },
                  //
                  //     onLongPress: () async {
                  //
                  //       bool permissionsGranted = await _checkAndRequestPermissions(context);
                  //       if (permissionsGranted) {
                  //         camera.hasPermission = true;
                  //         await availableCameras().then((value) {
                  //           local_value = value;
                  //           isReply = nav.selectedVideoUploadType == 'Video' ? false : true;
                  //           camera.shouldStartRecording = true;
                  //           camera.showCameraScreen = true;
                  //           log('DEBUG: Show camera screen and start recording');
                  //
                  //           // Start recording automatically when the screen opens
                  //           WidgetsBinding.instance.addPostFrameCallback((_) {
                  //             camera.startRecording();
                  //           });
                  //         });
                  //         print(true);
                  //       }
                  //     },
                  //     onLongPressEnd: (details) async {
                  //       // final camera = Provider.of<CameraProvider>(context, listen: false);
                  //       camera.stopRecording();
                  //     },
                  //     child: camera.showCameraScreen?RecordButton():CameraButton(isDark: isDark, nav: nav),
                  //   ),
                  // ],
                  // if (camera.showCameraScreen) ...[RecordButton()]
                  GestureDetector(
                    onTap: () async {
                      bool permissionsGranted = await _checkAndRequestPermissions(context);
                      if (permissionsGranted) {
                        camera.hasPermission = true;
                        await availableCameras().then((value) {
                          camera.localValue = value;
                          camera.isReply = nav.selectedVideoUploadType == 'Video' ? false : true;
                          camera.isThroughSingleTap=true;
                          camera.shouldStartRecording = false;
                          camera.showCameraScreen = true;

                        });
                      }
                    },

                    onLongPress: () async {
                      if(camera.recordingCompleted) return ;
                      camera.isLongPressed = true;
                      // Store the initial press position
                      camera.pressPosition = null;
                      bool permissionsGranted = await _checkAndRequestPermissions(context);
                      if (permissionsGranted) {
                        camera.hasPermission = true;
                        await availableCameras().then((value) {
                          camera.localValue = value;
                          camera.isReply = nav.selectedVideoUploadType == 'Video' ? false : true;
                          camera.shouldStartRecording = true;
                          camera.showCameraScreen = true;

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            camera.startRecording();
                          });
                        });
                      }
                    },

                    onLongPressMoveUpdate: (details) {
                      if(camera.recordingCompleted) return ;
                      if (camera.pressPosition == null) {
                        camera.pressPosition = details.globalPosition;
                      }
                      else{
                        double horizontalDifference = details.globalPosition.dx - camera.pressPosition!.dx;


                        if(horizontalDifference<-10){
                          camera.isLockIconHovered=true;
                        }else{
                          camera.isLockIconHovered=false;
                        }
                      }

                    },

                    onLongPressEnd: (details) async {
                      if(camera.recordingCompleted) return ;

                      if (camera.pressPosition != null) {
                        double horizontalDifference = details.globalPosition.dx - camera.pressPosition!.dx;
                        if (horizontalDifference < -20) {
                          camera.isRecordingLocked = true;
                          camera.isLockIconHovered=false;

                        }
                      }

                      camera.isLongPressed = false;
                      if (!camera.isRecordingLocked) {
                        camera.stopRecording();
                      }
                    },

                    child: camera.showCameraScreen ? RecordButton() : CameraButton(isDark: isDark, nav: nav),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
