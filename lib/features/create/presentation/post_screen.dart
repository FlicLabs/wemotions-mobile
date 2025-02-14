import 'package:socialverse/export.dart';

class PostScreenArgs {
  final bool isReply;
  final XFile? path;
  final int? parent_video_id;

  PostScreenArgs({this.path, required this.isReply, this.parent_video_id});
}

class PostScreen extends StatefulWidget {
  static const String routeName = '/post';
  
  final bool isReply;
  final int? parent_video_id;
  final XFile? path;

  const PostScreen({
    Key? key,
    this.path,
    required this.isReply,
    this.parent_video_id,
  }) : super(key: key);

  static Route route({required PostScreenArgs args}) {
    return SlideRoute(
      page: PostScreen(
        path: args.path,
        isReply: args.isReply,
        parent_video_id: args.parent_video_id,
      ),
    );
  }

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    _initPost();
  }

  void _initPost() {
    if (widget.path == null) {
      Navigator.pop(context); // Handle null case gracefully
      return;
    }
    
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    postProvider.initVideo(file: widget.path!);
    postProvider.getUploadToken();
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavBarProvider>(context);
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Consumer<PostProvider>(
        builder: (_, postProvider, __) {
          return postProvider.is_token_loading
              ? const CustomProgressIndicator()
              : _buildBody(context, postProvider, bottomNavProvider);
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.isReply ? 'Upload Reply' : 'Upload Post',
        style: TextStyle(
          color: Theme.of(context).indicatorColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, PostProvider postProvider, BottomNavBarProvider bottomNavProvider) {
    return Container(
      height: cs().height(context),
      width: cs().width(context),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildVideoPreview(postProvider),
                    height16,
                    Form(
                      key: postProvider.formKey,
                      child: PostTextFormField(controller: postProvider.description),
                    ),
                    height24,
                    const PostTagTile(),
                  ],
                ),
              ),
            ),
            _buildUploadButton(postProvider, bottomNavProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPreview(PostProvider postProvider) {
    return Center(
      child: Container(
        width: 200,
        height: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.transparent),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: postProvider.videoController != null
              ? VideoPlayer(postProvider.videoController!)
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget _buildUploadButton(PostProvider postProvider, BottomNavBarProvider bottomNavProvider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: AuthButtonWithColor(
        isGradient: true,
        onTap: () {
          if (postProvider.formKey.currentState!.validate()) {
            if (mounted) {
              Navigator.of(context, rootNavigator: true).pop();
            }
            postProvider.uploadVideo(
              path: widget.path!.path,
              isReply: widget.isReply,
              parent_video_id: widget.parent_video_id,
            );
            bottomNavProvider.currentPage = 0;
            bottomNavProvider.jumpToPage();
          }
        },
        title: 'Upload Video',
      ),
    );
  }
}
