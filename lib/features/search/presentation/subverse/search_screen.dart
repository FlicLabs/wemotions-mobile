import 'package:socialverse/export.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';
  const SearchScreen({Key? key}) : super(key: key);

  static Route route() {
    return SlideRoute(
      page: SearchScreen(),
    );
  }

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    final SearchProvider search =
        Provider.of<SearchProvider>(context, listen: false);
    search.tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 10,
            leading: shrink,
            leadingWidth: 0,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    // __.searchController.clear();
                    __.user_search.clear();
                    __.subverse_search.clear();
                    __.post_search.clear();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    // size: 22,
                    color: Theme.of(context).focusColor,
                  ),
                ),
                width10,
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: SearchBar(
                      readOnly: false,
                      controller: __.search,
                      onChanged: (query) {
                        __.onChanged(context, query: query);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).cardColor,
                      width: 2,
                    ),
                  ),
                ),
                child: TabBar(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: __.tabController,
                  indicatorColor: Theme.of(context).focusColor,
                  unselectedLabelStyle: Theme.of(context).textTheme.labelMedium,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(
                      text: 'Users',
                    ),
                    Tab(
                      text: 'Subverses',
                    ),
                    Tab(
                      text: 'Video',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: __.tabController,
                  children: [
                    UserSearchList(),
                    SubverseSearchList(),
                    PostSearchList(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
