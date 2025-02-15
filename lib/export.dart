// Flutter and Dart Core
export 'package:flutter/material.dart' hide SearchBar;
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/scheduler.dart' hide Flow, timeDilation;
export 'package:flutter/services.dart';
export 'dart:convert';
export 'dart:async';
export 'dart:io';

// Third-Party Packages
export 'package:firebase_core/firebase_core.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:share_plus/share_plus.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:video_player/video_player.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:wechat_assets_picker/wechat_assets_picker.dart';
export 'package:percent_indicator/percent_indicator.dart';
export 'package:path_provider/path_provider.dart';
export 'package:image_picker/image_picker.dart';
export 'package:image_cropper/image_cropper.dart';
export 'package:permission_handler/permission_handler.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:provider/provider.dart';

// Core Widgets
export 'package:socialverse/core/widgets/bottom_nav_bar.dart';
export 'package:socialverse/core/widgets/bottom_nav_item.dart';
export 'package:socialverse/core/widgets/custom_button.dart';
export 'package:socialverse/core/widgets/progress_indicator.dart';

// Authentication
export 'package:socialverse/features/auth/widgets/auth_sheet.dart';
export 'package:socialverse/features/auth/domain/models/user.dart';

// Home Feature
export 'package:socialverse/features/home/widgets/home_video/home_video_widget.dart';
export 'package:socialverse/features/home/domain/models/feed_model.dart';
export 'package:socialverse/features/home/domain/models/comment_model.dart';

// Search Feature
export 'package:socialverse/features/search/widgets/search/search_bar.dart';
export 'package:socialverse/features/search/widgets/subverse/subverse_widget.dart';
export 'package:socialverse/features/search/domain/models/search/post_search_model.dart';

// Profile Feature
export 'package:socialverse/features/profile/domain/models/user_post_model.dart';

// Services
export 'package:socialverse/core/services/api_service.dart';
export 'package:socialverse/core/services/auth_service.dart';

// Providers
export 'package:socialverse/core/providers/user_provider.dart';
export 'package:socialverse/core/providers/theme_provider.dart';

// Screens
export 'package:socialverse/features/home/screens/home_screen.dart';
export 'package:socialverse/features/auth/screens/login_screen.dart';
export 'package:socialverse/features/profile/screens/profile_screen.dart';
export 'package:socialverse/features/search/screens/search_screen.dart';
export 'package:socialverse/features/settings/screens/settings_screen.dart';
