import 'package:socialverse/export.dart';

class SubverseEmptyScreenArgs {
  final String category_name;
  final String category_desc;
  final int category_count;
  final int category_id;
  final bool fromVideoPlayer;
  final String category_photo;

  const SubverseEmptyScreenArgs({
    required this.category_name,
    required this.category_desc,
    required this.category_count,
    required this.category_id,
    required this.fromVideoPlayer,
    required this.category_photo,
  });
}

class SubverseEmptyScreen extends StatefulWidget {
  static const String routeName = '/subverse-empty';
  const SubverseEmptyScreen(
      {Key? key,
      required this.category_name,
      required this.category_desc,
      required this.category_count,
      required this.category_id,
      required this.fromVideoPlayer,
      required this.category_photo})
      : super(key: key);

  static Route route({required SubverseEmptyScreenArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => SubverseEmptyScreen(
        category_name: args.category_name,
        category_desc: args.category_desc,
        category_count: args.category_count,
        category_id: args.category_id,
        fromVideoPlayer: args.fromVideoPlayer,
        category_photo: args.category_photo,
      ),
    );
  }

  final String category_name;
  final String category_desc;
  final int category_count;
  final int category_id;
  final bool fromVideoPlayer;
  final String category_photo;

  @override
  State<SubverseEmptyScreen> createState() => _SubverseEmptyScreenState();
}

class _SubverseEmptyScreenState extends State<SubverseEmptyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.category_name,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.start,
        ),
      ),
      body: SizedBox(
        height: cs().height(context),
        width: cs().width(context),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubverseDetailHeader(
                    category_photo: widget.category_photo,
                    category_name: widget.category_name,
                    category_desc: widget.category_desc,
                    category_count: widget.category_count,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
