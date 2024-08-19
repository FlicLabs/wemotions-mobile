import 'package:socialverse/export.dart';

class HomeCommentWidget extends StatefulWidget {
  const HomeCommentWidget({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<HomeCommentWidget> createState() => _HomeCommentWidgetState();
}

class _HomeCommentWidgetState extends State<HomeCommentWidget> {
  fetchData() {
    Provider.of<CommentProvider>(context, listen: false).getComments(
      id: widget.id,
    );
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
      builder: (_, __, ___) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: SizedBox(
            width: cs().width(context),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: Text(
                    __.comment_list.length.toString() + ' Comments',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                height5,
                Divider(
                  thickness: 0.1,
                  color: Colors.grey,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      CommentSheet(),
                      CommentBar(id: widget.id),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
