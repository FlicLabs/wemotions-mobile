import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/utils/playback_sheet.dart';
import 'package:socialverse/features/home/utils/report_sheet.dart';

class VideoSheet extends StatelessWidget {
  const VideoSheet({
    Key? key,
    required this.isUser,
    this.isCallback,
    this.isFromFeed,
    this.isFromSubverse,
    required this.currentIndex,
    required this.categoryName,
    this.categoryDesc,
    required this.categoryCount,
    required this.categoryId,
    required this.categoryPhoto,
    this.isSubscribedRequired,
    required this.title,
    required this.videoLink,
    this.isFromProfile,
    this.videoId,
  }) : super(key: key);

  final bool isUser;
  final bool? isCallback;
  final bool? isFromFeed;
  final bool? isFromSubverse;
  final int currentIndex;
  final String categoryName;
  final String? categoryDesc;
  final int categoryCount;
  final int categoryId;
  final String categoryPhoto;
  final bool? isSubscribedRequired;
  final String title;
  final String videoLink;
  final bool? isFromProfile;
  final int? videoId;

  void startRecording() {
    print("Video recording started");
    // Implement actual video recording logic here
  }

  void stopRecording() {
    print("Video recording stopped");
    // Implement actual video recording stopping logic here
  }

  @override
  Widget build(BuildContext context) {
    final videoProvider = Provider.of<VideoProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    final notificationProvider = getIt<NotificationProvider>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        color: Theme.of(context).canvasColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 180,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        shrinkWrap: true,
        children: [
          _buildVideoOption(
            context,
            icon: Icons.file_download_rounded,
            label: 'Download',
            onTap: () {
              HapticFeedback.mediumImpact();
              videoProvider.saveVideo(videoUrl: videoLink, title: title);
              Navigator.pop(context);
            },
          ),
          _buildVideoOption(
            context,
            icon: Icons.report_problem_rounded,
            label: 'Report',
            onTap: () => Navigator.pop(context),
          ),
          _buildVideoOption(
            context,
            icon: Icons.videocam,
            label: 'Start Recording',
            onTap: startRecording,
          ),
          _buildVideoOption(
            context,
            icon: Icons.stop_circle,
            label: 'Stop Recording',
            onTap: stopRecording,
          ),
          if (isFromFeed == true)
            _buildVideoOption(
              context,
              icon: Icons.speed,
              label: 'Speed',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                  ),
                  builder: (context) => PlaybackSheet(),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildVideoOption(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).indicatorColor),
      title: Text(label),
      onTap: onTap,
    );
  }
}
