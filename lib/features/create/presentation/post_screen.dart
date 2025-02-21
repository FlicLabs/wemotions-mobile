import 'package:socialverse/export.dart';

import '../../../core/configs/page_routers/slide_route.dart';

class PostScreenArgs {
  bool isReply;
  final XFile? path;
  int? parent_video_id;
  PostScreenArgs({this.path, required this.isReply, this.parent_video_id});
}

class PostScreen extends StatefulWidget {
  static const String routeName = '/post';
  bool isReply;
  int? parent_video_id;
  PostScreen({Key? key, this.path, required this.isReply, this.parent_video_id})
      : super(key: key);

  static Route route({required PostScreenArgs args}) {
    return SlideRoute(
      page: PostScreen(
        path: args.path,
        isReply: args.isReply,
        parent_video_id: args.parent_video_id,
      ),
    );
  }

  final XFile? path;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  late final BottomNavBarProvider nav;
  late final CameraProvider camera;

  @override
  void initState() {
    initPost();
    nav= Provider.of<BottomNavBarProvider>(context,listen: false);
    camera = Provider.of<CameraProvider>(context,listen: false);
    super.initState();
  }

  initPost() {
    final post = Provider.of<PostProvider>(context, listen: false);
    post.initVideo(file: widget.path!);
    post.getUploadToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isReply ? 'Upload Reply' : 'Upload Post',
          style: TextStyle(
              color: Theme.of(context).indicatorColor,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: WillPopScope(

        onWillPop: () async{
          Navigator.of(context).pop();
          return false;
        },
        child: Consumer<PostProvider>(
          builder: (_, __, ___) {
            if (__.is_token_loading) {
              return CustomProgressIndicator();
            } else {
              return Container(
                height: cs.height(context),
                width: cs.width(context),
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 200,
                                          height: 320,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: VideoPlayer(
                                              __.videoController!,
                                            ),
                                          ),
                                        ),
                                        height16,
                                        Form(
                                          key: __.formKey,
                                          child: PostTextFormField(
                                            controller: __.description,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                height24,
                                PostTagTile(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: AuthButtonWithColor(
                          isGradient: true,
                          onTap: () async {
                            if (__.formKey.currentState!.validate()) {
                              if (mounted) {
                                // reset camera first
                                await camera.resetValues(isDisposing: true).whenComplete(() => Navigator.of(context, rootNavigator: true)..pop());

                                // Navigator.of(context, rootNavigator: true)..pop();
                              }
                              // __.addTag(postId)
                              print(widget.isReply.toString()+"111111111111111111111111111111111111111111");
                              print(widget.parent_video_id.toString()+"111111111111111111111111111111111111111111");
                              __.uploadVideo(
                                  path: widget.path!.path,
                                  isReply: widget.isReply,
                                  parent_video_id: widget.parent_video_id);
                              nav.currentPage = 0;
                              nav.jumpToPage();
                            }
                          },
                          title: 'Upload Video',
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
