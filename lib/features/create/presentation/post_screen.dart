import 'package:socialverse/export.dart';

class PostScreenArgs {
  bool isReply;
  final XFile? path;
  String? parent_video_id;
  PostScreenArgs({this.path,required this.isReply,this.parent_video_id});
}

class PostScreen extends StatefulWidget {
  static const String routeName = '/post';
  bool isReply;
  String? parent_video_id;
  PostScreen({Key? key, this.path, required this.isReply,this.parent_video_id}) : super(key: key);

  static Route route({required PostScreenArgs args}) {
    return SlideRoute(
      page: PostScreen(path: args.path, isReply: args.isReply,parent_video_id: args.parent_video_id,),
    );
  }

  final XFile? path;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    initPost();
    super.initState();
  }

  initPost() {
    final post = Provider.of<PostProvider>(context, listen: false);
    post.initVideo(file: widget.path!);
    post.getUploadToken();
  }

  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<BottomNavBarProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isReply ? 'New Reply' : 'New Post',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Consumer<PostProvider>(
        builder: (_, __, ___) {
          return __.is_token_loading
              ? CustomProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Form(
                                      key: __.formKey,
                                      child: PostTextFormField(
                                        controller: __.description,
                                      ),
                                    ),
                                    width10,
                                    Expanded(
                                      child: Container(
                                        height: cs().height(context) / 5,
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
                                    ),
                                  ],
                                )
                              ],
                            ),
                            height20,
                            PostListTile(),
                            height40,
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: TransparentButton(
                                onTap: () {
                                  if (__.formKey.currentState!.validate()) {
                                    if (mounted) {
                                      Navigator.of(context, rootNavigator: true)
                                        ..pop()
                                        ..pop();
                                    }
                                    __.uploadVideo(path: widget.path!.path,isReply: widget.isReply,parent_video_id: widget.parent_video_id);
                                    nav.currentPage = 0;
                                    nav.jumpToPage();
                                  }
                                },
                                title: widget.isReply ? 'Reply' : 'Post',
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
